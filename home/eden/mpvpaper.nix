{ config, ... }:

{
  programs.mpvpaper = {
    enable = config.programs.hyprland.enable && !config.services.hyprpaper.enable;

    pauseList = ''
      obs
    '';

    stopList = "";
  };
}
