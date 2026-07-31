{
  pkgs,
  config,
  inputs,
  ...
}:

{
  imports = [
    inputs.homebrew.darwinModules.nix-homebrew

    ./env.nix
  ];

  config = {
    nix-homebrew = {
      enable = true;

      package = pkgs.fetchFromGitHub {
        owner = "homebrew";
        repo = "brew";
        tag = "6.0.13";
        hash = "sha256-Sa7/HrfB04H32OJ7/ofxXjiZEbkWtCNOriONYYTL1OA=";
      };

      mutableTaps = false;
      user = config.pixel.system.mainUser;

      # `nix-prefetch-github homebrew homebrew-core --nix`
      taps = {
        "homebrew/homebrew-core" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-core";
          rev = "b1c9e2bb85ca4c01fac98a1e8588a8c174beb40f";
          hash = "sha256-uWmdS4yw+coRgCICZZuw8WX2rbQmDEdpNhkguBYBVGI=";
        };

        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "f5262d4629bd76d5c3e3b81be5f74b1f1d20dc54";
          hash = "sha256-p8fLbFQoCM6YetY/gPpkC2x3uncJy7slsLvOKOF0Tsw=";
        };
      };
    };

    # https://brew.sh
    homebrew = {
      enable = true;

      caskArgs.require_sha = true;
      global.autoUpdate = false;

      onActivation = {
        # autoUpdate = true; # should be managed by nix-homebrew
        upgrade = true;
        # 'zap': uninstalls all formulae [ & related files ] not listed here.
        cleanup = "zap";
      };

      # https://github.com/mas-cli/mas
      masApps = {
        "Encrypto" = 935235287;
        "iMovie" = 408981434;
        "Keynote" = 361285480;
        "Numbers" = 361304891;
        "Pages" = 361309726;
        "Xcode" = 497799835;
      };

      taps = builtins.attrNames config.nix-homebrew.taps;

      # `brew install`
      brews = [ "mole" ];

      # `brew install --cask`
      casks = [
        "ghostty"
        # "intellij-idea"
        # "jordanbaird-ice@beta"
        "notion"
        "whatsapp"
      ];
    };
  };
}
