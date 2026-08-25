{
  lib,
  pkgs,
  osConfig,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf (pkgs.stdenv.hostPlatform.isLinux && osConfig.pixel.device.gpu == "nvidia") {
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
