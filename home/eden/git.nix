{
  lib,
  self,
  pkgs,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.attrsets) mergeAttrsList;
  inherit (lib.hm.dag) entryBefore;
  inherit (lib.modules) mkIf;
  inherit (self.lib) giturl;
in

{
  config = mkIf config.pixel.profiles.workstation.enable {
    programs = {
      git = {
        enable = true;
        package = pkgs.gitMinimal;

        lfs = {
          enable = false;
          skipSmudge = true;
        };

        signing = {
          format = "openpgp";
          key = "D37104E7AF99F817";
          signByDefault = true;
        };

        includes = [
          { path = "${config.xdg.configHome}/git/alias.conf"; }
        ];

        ignores = [
          # Build residue
          "*.dll"
          "*.dylib"
          "*.exe~"
          "*.exe"
          "*.so"
          "build/"
          "dist/"
          "result"
          "result-*"
          "target/"
          "tmp/"

          # Compressed files
          "*.7z"
          "*.dmg"
          "*.gz"
          "*.iso"
          "*.jar"
          "*.msi"
          "*.rar"
          "*.tar"
          "*.zip"

          # Dependencies
          ".direnv/"
          "node_modules/"
          "npm-debug.log*"
          "package-lock.json"
          "vendor/"
          "yarn-error.log*"

          # Editor files
          "*~"
          "*.bak"
          "*.backup"
          "*.orig"
          "*.ref"
          "*.sublime-workspace"
          "*.swk"
          "*.swl"
          "*.swm"
          "*.swn"
          "*.swo"
          "*.swp"
          ".idea"
          ".iml"
          ".vscode"

          # Logs
          "*.log"
          "*.sqlite"
          "log.txt"

          # PhpStorm HTTP Requests
          ".http/"

          # Python
          "__pycache__/"
          "*.pyc"

          # Rust
          "**/*.rl.bk"
          "**/*.rs.bk"

          # Sensitive files
          "*.credentials"
          "*.env"
          "*.key"
          "*.password"
          "*.pem"
          "*.secret"

          # System files
          "*.bak"
          "*.elc"
          "*.swo"
          "*.swp"
          ".~lock*"
          ".cache/"
          ".DS_Store"
          ".Trashes"
          ".Trash-*"
          ".uuid"
          "Desktop.ini"
          "Thumbs.db"
        ];

        settings = {
          user = {
            name = "Eden";
            email = "azurehound.landline090" + "@" + "slmail" + "." + "me"; # obsfuscate email to prevent webscrapper spam
          };

          alias = {
            st = "status";
            br = "branch";
            c = "commit -m";
            ca = "commit -am";
            co = "checkout";
            d = "diff";
            df = "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
            fuck = "commit --amend -m";
            graph = "log --all --decorate --graph";
            ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
            pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
            af = "!git add $(git ls-files -m -o --exclude-standard | fzf -m)";
            hist = ''
              log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all
            '';
            llog = ''
              log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative
            '';
            # https://github.com/arichtman/nix/blob/18f5613c2842e12e49350aeceace63863ad59244/modules/home/default-home/default.nix#L11
            fuggit = "!git add . && git commit --amend --no-edit && git push --force";
            idc = "!git commit -am '$(curl -s https://whatthecommit.com/index.txt)'";
          };

          core = {
            editor = "nvim";
            whitespace = "fix,-indent-with-non-tab,trailing-space";
            compression = 6;
            preloadindex = true;
          };

          init.defaultBranch = "main";

          safe.directory = "~/Developer";

          commit = {
            # gpgSign = true;
            template = "${config.xdg.configHome}/git/gitmessage";
            verbose = true;
          };

          branch = {
            autosetupmerge = true;
            sort = "-committerdate";
          };

          status = {
            short = true;
            branch = true;
            showStash = true;
            submoduleSummary = true;
            showUntrackedFiles = "all";
          };

          log = {
            abbrevCommit = true;
            date = "human";
            decorate = "short";
            follow = true;
            graphColors = "blue,yellow,cyan,magenta,green,red";
          };

          diff = {
            algorithm = "histogram";
            context = 3;
            colorMoved = "plain";
            interHunkContext = 10;
            mnemonicPrefix = true;
            renames = "copies";
            submodule = "log";
          };

          blame = {
            blankBoundary = true;
            coloring = "repeatedLines";
            date = "human";
          };

          tag.sort = "-taggerdate";

          submodule.recurse = true;

          fetch = {
            fsckObjects = true;
            prune = true;
          };

          pull = {
            default = "current";
            ff = "only";
            rebase = true;
          };

          push = {
            default = "current";
            autoSetupRemote = true;
            followTags = true;
          };

          merge = {
            conflictstyle = "zdiff3";
            stat = true;
            tool = "nvim";
          };

          mergetool = {
            hideResolve = true;
            keepBackup = false;
            prompt = false;
            writeToTemp = true;
            "nvim".cmd = "nvim -d -c \"wincmd l\" -c \"norm ]c\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
          };

          rebase = {
            autoStash = true;
            autoSquash = true;
            missingCommitsCheck = "warn";
            updateRefs = true; # https://andrewlock.net/working-with-stacked-branches-in-git-is-easier-with-update-refs/
          };

          rerere = {
            autoupdate = true;
            enabled = true;
          };

          http = {
            lowSpeedLimit = 1000;
            lowSpeedTime = 60;
            postBuffer = 524288000;
          };

          transfer.fsckObjects = true;
          receive.fsckObjects = true;
          repack.usedeltabaseoffset = true;

          color = {
            ui = true;
            grep = "auto";
            branch = {
              current = "magenta";
              local = "default";
              remote = "yellow";
              upstream = "green";
              plain = "blue";
            };
            diff = {
              old = "red strike";
              new = "green italic";
            };
          };

          column.ui = "auto";

          advice = {
            addEmptyPathspec = false;
            addIgnoredFile = false;
            pushNonFastForward = false;
            statusHints = true;
          };

          help.autocorrect = 10;

          url = mergeAttrsList (
            map giturl [
              {
                domain = "aur.archlinux.org";
                alias = "aur";
                user = "aur";
              }
              {
                domain = "codeberg.org";
                alias = "codeberg";
              }
              {
                domain = "forgejo.softshell.duckdns.org";
                alias = "forgejo";
              }
              {
                domain = "github.com";
                alias = "github";
              }
              {
                domain = "gitlab.com";
                alias = "gitlab";
              }
            ]
          );
        };
      };

      delta = {
        inherit (config.pixel.profiles.workstation) enable;
        enableGitIntegration = true;

        options = {
          decoration = true;
          hyperlinks = true;
          side-by-side = true;
          true-color = "always";
          line-numbers = true;
          line-numbers-right-format = "│ ";
          navigate = true;
        };
      };
    };

    home = {
      activation = mkIf (pkgs.stdenv.hostPlatform.isDarwin && config.programs.git.enable) {
        removeExistingGitconfig = entryBefore [ "checkLinkTargets" ] ''
          rm -f ~/.gitconfig
        '';
      };

      shellAliases = {
        # branch = ''git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff --color=always {1} | delta" --pointer=" " | xargs git checkout'';
        glogs = "git log --oneline --graph --all";
        gr = ''cd "$(git rev-parse --show-toplevel)"'';
      };
    };

    xdg.configFile = mkCfgLink (
      map (f: "git/${f}") [
        # "alias.conf"
        "gitmessage"
      ]
    );
  };
}
