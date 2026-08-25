{ pkgs, config, ... }:

{
  services.wlsunset = {
    enable = pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable;

    latitude = 23.83;
    longitude = 91.28;

    temperature = {
      night = 4000;
      day = 6500;
    };
  };
}
