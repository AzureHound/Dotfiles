#!/usr/bin/env bash

usage() {
  echo "usage: update-pins [chromium|brew]..." >&2
  exit 2
}

FLAKE_ROOT="${FLAKE:-$(git rev-parse --show-toplevel)}"

CHROMIUM_FILE="$FLAKE_ROOT/home/eden/chromium.nix"
BREW_FILE="$FLAKE_ROOT/modules/darwin/brew/default.nix"

# shellcheck disable=SC2329
prefetch_github() {
  nurl -H "https://github.com/$1/$2" "$3"
}

# shellcheck disable=SC2329
is_sri() {
  [[ $1 =~ ^sha256-[A-Za-z0-9+/]{43}=$ ]]
}

# shellcheck disable=SC2329
crx_url() {
  echo "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${CHROME_MAJOR}&x=id%3D${1}%26installsource%3Dondemand%26uc"
}

# shellcheck disable=SC2329
update_chromium() {
  local version
  if [ -n "${CHROME_VERSION:-}" ]; then
    version="$CHROME_VERSION"
  else
    version=$(nix eval --raw "$FLAKE_ROOT#nixosConfigurations.$(hostname).config.home-manager.users.eden.programs.chromium.package.version")
  fi
  CHROME_MAJOR="${version%%.*}"

  local id current location latest hash rc=0 count=0
  while read -r id; do
    count=$((count + 1))
    current=$(sed -n "/id = \"$id\"/,/}/ s/.*version = \"\(.*\)\";.*/\1/p" "$CHROMIUM_FILE") || {
      echo "chromium/$id: failed to read current version" >&2
      rc=1
      continue
    }

    location=$(curl -fsI "$(crx_url "$id")" | tr -d '\r' | sed -n 's/^[Ll]ocation: //p') || {
      echo "chromium/$id: version discovery failed" >&2
      rc=1
      continue
    }

    # CJPAL..._1_72_2_0.crx -> 1.72.2; the store pads versions to four
    # components, so strip one trailing .0 (a real 4-part version ending
    # in .0 would be mis-parsed, none of ours are)
    latest=$(basename "$location" .crx)
    latest=${latest#"${id^^}"_}
    latest=${latest//_/.}
    if [[ $latest == *.*.*.* ]]; then
      latest=${latest%.0}
    fi

    [[ $latest =~ ^[0-9]+(\.[0-9]+)*$ ]] || {
      echo "chromium/$id: unexpected version '$latest'" >&2
      rc=1
      continue
    }

    if [ "$latest" = "$current" ]; then
      echo "chromium/$id: up to date ($current)"
      continue
    fi

    hash=$(nix store prefetch-file --name "$id.crx" --json "$(crx_url "$id")" | jq -r .hash) || {
      echo "chromium/$id: prefetch failed" >&2
      rc=1
      continue
    }
    is_sri "$hash" || {
      echo "chromium/$id: unexpected hash '$hash'" >&2
      rc=1
      continue
    }

    sed -i "/id = \"$id\"/,/}/ {
      s|version = \".*\";|version = \"$latest\";|
      s|hash = \".*\";|hash = \"$hash\";|
    }" "$CHROMIUM_FILE" || {
      echo "chromium/$id: failed to edit $CHROMIUM_FILE" >&2
      rc=1
      continue
    }
    echo "chromium/$id: $current -> $latest"
  done < <(sed -n 's/.*id = "\([a-p]\{32\}\)";.*/\1/p' "$CHROMIUM_FILE")

  if [ "$count" -eq 0 ]; then
    echo "chromium: found no extension ids in $CHROMIUM_FILE" >&2
    return 1
  fi

  return "$rc"
}

# shellcheck disable=SC2329
update_brew() {
  local tag current hash repo rev rc=0

  tag=$(gh api "repos/homebrew/brew/releases/latest" --jq .tag_name) || {
    echo "brew: failed to query the latest release" >&2
    return 1
  }
  [[ $tag =~ ^[0-9A-Za-z._-]+$ ]] || {
    echo "brew: unexpected tag '$tag'" >&2
    return 1
  }
  current=$(sed -n 's/.*tag = "\(.*\)";.*/\1/p' "$BREW_FILE") || {
    echo "brew: failed to read current pin" >&2
    return 1
  }
  if [ "$tag" = "$current" ]; then
    echo "brew: up to date ($tag)"
  else
    hash=$(prefetch_github homebrew brew "$tag") || {
      echo "brew: prefetch failed for tag $tag" >&2
      return 1
    }
    is_sri "$hash" || {
      echo "brew: unexpected hash '$hash'" >&2
      return 1
    }
    sed -i "/repo = \"brew\";/,/}/ {
      s|tag = \".*\";|tag = \"$tag\";|
      s|hash = \".*\";|hash = \"$hash\";|
    }" "$BREW_FILE" || {
      echo "brew: failed to edit $BREW_FILE" >&2
      return 1
    }
    echo "brew: $current -> $tag"
  fi

  for repo in homebrew-core homebrew-cask; do
    rev=$(gh api "repos/homebrew/$repo/commits/HEAD" --jq .sha) || {
      echo "$repo: failed to query HEAD" >&2
      rc=1
      continue
    }
    [[ $rev =~ ^[0-9a-f]{40}$ ]] || {
      echo "$repo: unexpected rev '$rev'" >&2
      rc=1
      continue
    }
    current=$(sed -n "/repo = \"$repo\";/,/}/ s/.*rev = \"\(.*\)\";.*/\1/p" "$BREW_FILE") || {
      echo "$repo: failed to read current pin" >&2
      rc=1
      continue
    }
    if [ "$rev" = "$current" ]; then
      echo "$repo: up to date (${rev:0:12})"
      continue
    fi
    hash=$(prefetch_github homebrew "$repo" "$rev") || {
      echo "$repo: prefetch failed for ${rev:0:12}" >&2
      rc=1
      continue
    }
    is_sri "$hash" || {
      echo "$repo: unexpected hash '$hash'" >&2
      rc=1
      continue
    }
    sed -i "/repo = \"$repo\";/,/}/ {
      s|rev = \".*\";|rev = \"$rev\";|
      s|hash = \".*\";|hash = \"$hash\";|
    }" "$BREW_FILE" || {
      echo "$repo: failed to edit $BREW_FILE" >&2
      rc=1
      continue
    }
    echo "$repo: ${current:0:12} -> ${rev:0:12}"
  done

  return "$rc"
}

failed=0

run_target() {
  if ! "update_$1"; then
    echo "$1: FAILED" >&2
    failed=1
  fi
}

main() {
  local -a targets=("$@")
  if [ ${#targets[@]} -eq 0 ]; then
    targets=(chromium brew)
  fi

  local t
  for t in "${targets[@]}"; do
    case "$t" in
    chromium | brew) run_target "$t" ;;
    *) usage ;;
    esac
  done

  exit "$failed"
}

main "$@"
