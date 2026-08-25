{
  pkgs,
  mkpkg,
  config,
  ...
}:

{
  home.pointerCursor = {
    enable = pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable;

    package = mkpkg.banana-cursor;
    name = "Banana-Catppuccin-Macchiato";
    # package = pkgs.bibata-cursors;
    # name = "Bibata-Modern-Ice";
    size = 48;
    dotIcons.enable = false;
    gtk.enable = true;
    x11.enable = true;

    hyprcursor.enable = config.programs.hyprland.enable;
    sway.enable = config.programs.sway.enable;
  };
}
