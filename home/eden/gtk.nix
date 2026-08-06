{
  lib,
  pkgs,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.modules) mkIf;

  cfg = config.pixel.style;

  schema = pkgs.gsettings-desktop-schemas;
in

{
  config = mkIf (config.pixel.profiles.graphical.enable && pkgs.stdenv.hostPlatform.isLinux) {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/nautilus/preferences" = {
        show-hidden-files = true;
      };
      "org/gtk/settings/file-chooser" = {
        show-hidden = true;
      };
      "org/gtk/gtk4/settings/file-chooser" = {
        show-hidden = true;
      };
    };

    gtk = {
      enable = true;

      colorScheme = "dark";
      theme = {
        name = "Catppuccin-GTK-Blue-Dark-Macchiato";
        package = pkgs.magnetic-catppuccin-gtk.override {
          accent = [ "blue" ];
          shade = "dark";
          tweaks = [
            # "frappe"
            "macchiato"
            # "black"
            # "float"
            # "outline"
            "macos"
          ];
        };
      };

      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };

      font = {
        name = "Josefin Sans";
        inherit (cfg.fonts) size;
      };

      gtk3.extraConfig = {
        gtk-decoration-layout = "appmenu:none";

        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";

        gtk-enable-event-sounds = 1;
        gtk-enable-input-feedback-sounds = 1;
        gtk-error-bell = 0;

        gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";

        gtk-button-images = 0;
        gtk-menu-images = 0;
      };

      gtk4 = {
        inherit (config.gtk) theme;

        extraConfig = {
          gtk-decoration-layout = "appmenu:none";

          gtk-xft-antialias = 1;
          gtk-xft-hinting = 1;
          gtk-xft-hintstyle = "hintslight";
          gtk-xft-rgba = "rgb";

          gtk-enable-event-sounds = 1;
          gtk-enable-input-feedback-sounds = 1;
          gtk-error-bell = 0;
        };
      };
    };

    home = {
      packages = with pkgs; [
        glib # gsettings
      ];

      sessionVariables = {
        GTK_USE_PORTAL = "1";
      };
    };

    xdg = {
      configFile = mkCfgLink [
        "gtk-3.0/bookmarks"
        "gtk-4.0/servers"
      ];

      systemDirs.data = [ "${schema}/share/gsettings-schemas/${schema.name}" ];
    };

    # Theme
    catppuccin.gtk.icon.enable = false;
  };
}
