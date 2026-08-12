{ config, ... }:

{
  programs.hyprland-qt-support = {
    inherit (config.programs.hyprland) enable;

    settings = {
      theme = {
        style = "kvantum-dark";
        icon_theme = "Catppuccin-SE";
        color_scheme = "Catppuccin-Macchiato";
        font = "Josefin Sans";
        font_size = 12;
        font_fixed = "JetBrainsMono Nerd Font";
        font_fixed_size = 12;
      };

      misc = {
        menus_have_icons = true;
        single_click_activate = true;
        shortcuts_for_context_menus = true;
      };
    };
  };
}
