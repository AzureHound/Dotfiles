{ pkgs, config, ... }:

{
  programs.wiremix = {
    enable = pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable;

    settings = {
      fps = 30.0;
      max_volume_percent = 100.0;
      enforce_max_volume = true;

      themes.default = {
        selector = {
          fg = "#b7bdf8";
        };
        tab_selected = {
          fg = "#8aadf4";
        };
        tab_marker = {
          fg = "#8aadf4";
        };
        volume_filled = {
          fg = "#8aadf4";
        };
        meter_active = {
          fg = "#a6da95";
        };
        meter_overload = {
          fg = "#ed8796";
        };
        meter_center_active = {
          fg = "#a6da95";
        };
        dropdown_selected = {
          fg = "#8aadf4";
          add_modifier = "REVERSED";
        };
      };
    };
  };
}
