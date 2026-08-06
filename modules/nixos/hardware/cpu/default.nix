{ lib, ... }:

let
  inherit (lib.options) mkOption;
  inherit (lib) types;
in

{
  imports = [
    ./amd.nix
    ./intel.nix
  ];

  options.pixel.device.cpu = mkOption {
    type = types.nullOr (
      types.enum [
        "amd"
        "intel"
      ]
    );
    default = null;
  };
}
