{
  description = "dotfiles";

  outputs = inputs: import ./modules/flake inputs;

  inputs = {
    # https://nix.dev/manual/nix/stable/protocols/tarball-fetcher#lockable-http-tarball-protocol
    # http://web.archive.org/web/20250806225139/https://nix.dev/manual/nix/2.28/protocols/tarball-fetcher#lockable-http-tarball-protocol
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";

    # nixos-raspberrypi = {
    #   type = "github";
    #   owner = "nvmd";
    #   repo = "nixos-raspberrypi";
    #   ref = "main";
    # };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    autoaspm = {
      type = "git";
      url = "https://git.notthebe.ee/notthebee/AutoASPM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      type = "github";
      owner = "nix-community";
      repo = "disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops = {
      type = "github";
      owner = "Mic92";
      repo = "sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      type = "github";
      owner = "nix-darwin";
      repo = "nix-darwin";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homebrew = {
      type = "github";
      owner = "zhaofengli";
      repo = "nix-homebrew";
      inputs.brew-src.follows = "";
    };

    nur = {
      type = "github";
      owner = "nix-community";
      repo = "NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      type = "github";
      owner = "nix-community";
      repo = "nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify = {
      type = "github";
      owner = "Gerg-L";
      repo = "spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      type = "github";
      owner = "0xc000022070";
      repo = "zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    millennium = {
      type = "github";
      owner = "re1n0";
      repo = "nixos-millennium";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      type = "github";
      owner = "hyprwm";
      repo = "Hyprland";
    };

    hyprland-plugins = {
      type = "github";
      owner = "hyprwm";
      repo = "hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # nixbot = {
    #   type = "github";
    #   owner = "Mic92";
    #   repo = "nixbot";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    apple-fonts = {
      type = "github";
      owner = "Lyndeno";
      repo = "apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      type = "github";
      owner = "catppuccin";
      repo = "nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pi-catppuccin = {
      type = "github";
      owner = "otahontas";
      repo = "pi-coding-agent-catppuccin";
    };
  };
}
