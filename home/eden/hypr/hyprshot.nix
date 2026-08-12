{ config, ... }:

{
  programs.hyprshot = {
    inherit (config.programs.hyprland) enable;

    saveLocation = "~/Pictures/screenshots";
  };
}
