{ config, ... }:

{
  programs.mpvpaper = {
    enable = config.programs.hyprland.enable;

    pauseList = ''
      obs
    '';

    stopList = "";
  };
}
