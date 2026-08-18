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
        tag = "6.0.18";
        hash = "sha256-VBESSoJccikdhxh3vp3SQeG7cZXTOulMvVkoSqNDEhs=";
      };

      mutableTaps = false;
      user = config.pixel.system.mainUser;

      # `nix-prefetch-github homebrew homebrew-core --nix`
      taps = {
        "homebrew/homebrew-core" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-core";
          rev = "7164fab9c50b8777e91b088a41c377302b939a5c";
          hash = "sha256-7rFNjl/AZuHEij8Sc2BWB7e1smE8PHDswyDIMwgOqvw=";
        };

        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "e301311f748be8addb89fb96882bb21fd8bf8e07";
          hash = "sha256-rrA+B9+eYxH3IIM3YXTM3ZKhtZvqmI8qWA+XepJ4l+o=";
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
