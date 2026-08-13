{
  pkgs,
  mkpkg,
  config,
  ...
}:

{
  home.pointerCursor = {
    enable = config.pixel.profiles.graphical.enable && pkgs.stdenv.hostPlatform.isLinux;

    package = mkpkg.banana-cursor;
    name = "Banana-Catppuccin-Macchiato";
    # package = pkgs.bibata-cursors;
    # name = "Bibata-Modern-Ice";
    size = 48;
    dotIcons.enable = false;
    gtk.enable = true;
    x11.enable = true;
  };
}
