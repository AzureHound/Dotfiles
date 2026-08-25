{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf (pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable) {
    qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme.name = "qtct";

      qt5ctSettings = {
        Appearance = {
          style = "kvantum-dark";
          standard_dialogs = "xdgdesktopportal";
        };

        Fonts = {
          general = "\"Josefin Sans,12\"";
          fixed = "\"JetBrainsMono Nerd Font,12\"";
        };
      };

      qt6ctSettings = {
        Appearance = {
          style = "kvantum-dark";
          custom_palette = true;
          standard_dialogs = "xdgdesktopportal";
        };

        Fonts = {
          general = "\"Josefin Sans,12\"";
          fixed = "\"JetBrainsMono Nerd Font,12\"";
        };
      };
    };

    home = {
      packages =
        with pkgs;
        [
          (catppuccin-kvantum.override {
            accent = "lavender";
            variant = "macchiato";
          })
        ]
        ++ (with pkgs.libsForQt5; [
          catppuccin-qt5ct
          qtstyleplugin-kvantum
        ])
        ++ (with pkgs.kdePackages; [
          qt6ct
          qtstyleplugin-kvantum
        ]);

      sessionVariables = {
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_SCALE_FACTOR = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

        DISABLE_QT5_COMPAT = "1";
      };
    };

    # Theme
    catppuccin = {
      kvantum = {
        apply = true;
        accent = "lavender";
      };
      qt5ct.enable = true;
    };
  };
}
