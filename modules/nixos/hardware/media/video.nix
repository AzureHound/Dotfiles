{ lib, config, ... }:

let
  inherit (lib.modules) mkDefault;
in

{
  hardware.graphics.enable = mkDefault (config.pixel.profiles.graphical.enable || config.pixel.device.gpu != null);
}
