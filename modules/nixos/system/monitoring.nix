{ lib, config, ... }:

let
  inherit (lib.modules) mkDefault;
in

{
  services = {
    thermald.enable = config.pixel.profiles.laptop.enable;
    smartd.enable = true;
    lvm.enable = mkDefault false;
  };
}
