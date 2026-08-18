{
  lib,
  writeShellScriptBin,
  treefmt,

  actionlint,
  deadnix,
  locker,
  nixfmt,
  shellcheck,
  shfmt,
  statix,
  stylua,
  taplo,
  typos,
  yamlfmt,
  zizmor,
}:

treefmt.withConfig {
  runtimeInputs = [
    actionlint
    deadnix
    locker
    nixfmt
    shellcheck
    shfmt
    statix
    stylua
    taplo
    typos
    yamlfmt
    zizmor

    (writeShellScriptBin "statix-fix" ''
      for file in "$@"; do
        ${lib.meta.getExe statix} fix "$file"
      done
    '')
  ];

  settings = {
    on-unmatched = "info";
    tree-root-file = "flake.nix";

    excludes = [
      ".envrc"
      ".prettierignore"
      "secrets/*"
    ];

    global.excludes = [
      "*.jpg"
      "*.jpeg"
      "*.webp"
      "*.png"
      "LICENSE"
    ];

    formatter = {
      actionlint = {
        command = "actionlint";
        includes = [
          ".github/workflows/*.yml"
          ".github/workflows/*.yaml"
        ];
      };

      deadnix = {
        command = "deadnix";
        options = [ "--edit" ];
        includes = [ "*.nix" ];
      };

      locker = {
        command = "locker";
        includes = [ "flake.lock" ];
      };

      nixfmt = {
        command = "nixfmt";
        includes = [ "*.nix" ];
      };

      shellcheck = {
        command = "shellcheck";
        includes = [
          "*.sh"
          "*.bash"

          "*.envrc"
          "*.envrc.*"
        ];
      };

      shfmt = {
        command = "shfmt";
        options = [
          "-s"
          "-w"
          "-i"
          "2"
        ];
        includes = [
          "*.sh"
          "*.bash"

          "*.envrc"
          "*.envrc.*"
        ];
      };

      statix = {
        command = "statix-fix";
        includes = [ "*.nix" ];
      };

      stylua = {
        command = "stylua";
        includes = [ "*.lua" ];
      };

      taplo = {
        command = "taplo";
        options = "format";
        includes = [ "*.toml" ];
      };

      typos = {
        command = "typos";
        options = [ "--write-changes" ];
        includes = [
          "*.nix"
          "*.md"
        ];
        excludes = [
          # colors
          "modules/nixos/theme.nix"
          # driver name
          "modules/nixos/hardware/gpu/nvidia.nix"
        ];
      };

      yamlfmt = {
        command = "yamlfmt";
        options = [
          "-formatter"
          "retain_line_breaks_single=true"
        ];
        includes = [
          "*.yml"
          "*.yaml"
        ];
      };

      zizmor = {
        command = "zizmor";
        includes = [
          ".github/workflows/*.yml"
          ".github/workflows/*.yaml"
        ];
      };
    };
  };
}
