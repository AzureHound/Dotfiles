{ pkgs, config, ... }:

{
  services.wlsunset = {
    enable = config.pixel.profiles.graphical.enable && pkgs.stdenv.hostPlatform.isLinux;

    latitude = 23.83;
    longitude = 91.28;

    temperature = {
      night = 4000;
      day = 6500;
    };
  };
}
