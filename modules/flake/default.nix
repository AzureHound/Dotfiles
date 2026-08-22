inputs:

let
  inherit (inputs) nixpkgs self;
  inherit (nixpkgs) lib;

  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];

  forAllSystems = fn: lib.attrsets.genAttrs systems (system: fn nixpkgs.legacyPackages.${system});

  mkHosts = lib.attrsets.mapAttrs self.lib.mkHost;
in

{
  legacyPackages = forAllSystems (pkgs: import ./pkgs { inherit pkgs inputs; });

  devShells = forAllSystems (pkgs: {
    default = pkgs.callPackage ./programs/devshell.nix {
      treefmt-wrapped = self.formatter.${pkgs.stdenv.hostPlatform.system};
    };
  });

  lib = import ./lib { inherit lib inputs; };

  checks = forAllSystems (pkgs: import ./checks { inherit pkgs inputs; });

  formatter = forAllSystems (pkgs: pkgs.callPackage ./programs/formatter.nix { });

  # Hosts
  nixosConfigurations = mkHosts {
    # Legion = {
    #   arch = "aarch64-linux";
    # };
    Notebook = { };
    Orion = { };
    Nyx = {
      class = "iso";
    };
  };

  darwinConfigurations = mkHosts {
    Newton = {
      arch = "aarch64";
      class = "darwin";
    };
  };
}
