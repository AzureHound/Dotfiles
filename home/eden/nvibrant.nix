{ lib, osConfig, ... }:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf (osConfig.pixel.device.gpu == "nvidia") {
    services.nvibrant = {
      enable = true;

      dithering = [
        true
      ];
      vibrancy = [
        "150%"
      ];
    };
  };
}
