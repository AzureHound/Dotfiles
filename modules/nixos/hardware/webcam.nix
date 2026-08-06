{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in

{
  options.pixel.device.webcam = mkEnableOption "webcam";

  config = mkIf config.pixel.device.webcam {
    pixel.system.security.fixWebcam = true;

    boot = {
      kernelModules = [ "v4l2loopback" ];

      extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

      extraModprobeConfig = ''
        options v4l2loopback exclusive_caps=1,1 video_nr=3,4 card_label="Pixel,Sony"
      '';
    };
  };
}
