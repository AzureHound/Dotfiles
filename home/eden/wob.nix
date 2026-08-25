{ pkgs, config, ... }:

{
  services.wob = {
    enable = pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable;

    settings = {
      "" = {
        timeout = 1000;
        max = 100;

        width = 400;
        height = 20;
        margin = 10;
        border_offset = 0;
        bar_padding = 0;
        border_size = 0;

        orientation = "horizontal";
        anchor = "bottom center";

        border_color = "00000000";
        background_color = "363a4fff";
        bar_color = "b7bdf8ff";
      };
    };
  };
}
