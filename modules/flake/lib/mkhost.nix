{ lib, inputs, ... }:

let
  inherit (inputs) self;
  inherit (lib.attrsets) mapAttrs;

  name = "eden";
in

hostname:
{
  arch ? "x86_64",
  class ? "nixos",
}:
let
  inherit (inputs) darwin nixpkgs;

  inputs' = mapAttrs (_: mapAttrs (_: v: v.${system} or v)) inputs;

  os =
    {
      iso = "linux";
      nixos = "linux";
    }
    .${class} or class;
  system = "${arch}-${os}";

  evalHost = if class == "darwin" then darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
in

evalHost {
  specialArgs = {
    inherit inputs name self;
  };

  modules = [
    "${self}/hosts/${hostname}"
    "${self}/modules/${class}"

    {
      key = "dotfiles#specialArgs";
      _file = "${__curPos.file}";

      _module.args = {
        inherit inputs';
        self' = inputs'.self;
      };
    }

    {
      key = "dotfiles#hostname";
      _file = "${__curPos.file}";

      networking.hostName = hostname;
    }

    {
      key = "dotfiles#nixpkgs";
      _file = "${__curPos.file}";

      nixpkgs.hostPlatform = system;
    }
  ]
  ++ lib.lists.optionals (class == "darwin") [
    {
      key = "dotfiles#nixpkgs-darwin";
      _file = "${__curPos.file}";

      nixpkgs.source = nixpkgs;
    }
    {
      key = "dotfiles#darwin-hostnames";
      _file = "${__curPos.file}";

      networking = {
        computerName = hostname;
        localHostName = hostname;
      };
      system.defaults.smb.NetBIOSName = hostname;
    }
  ];
}
