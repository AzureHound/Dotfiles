{ pkgs, config, ... }:

{
  services.udiskie = {
    enable = pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable;

    tray = "never";
    automount = true;
    notify = true;
  };
}
