{
  lib,
  mkpkg,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    services = {
      swaync = {
        enable = config.programs.hyprland.enable;
        package = mkpkg.swaync;

        settings = {
          ignore-gtk-theme = true;
          cssPriority = "user";
          layer = "overlay";
          layer-shell = true;
          layer-shell-cover-screen = true;
          positionY = "top";
          positionX = "right";

          control-center-layer = "top";
          control-center-height = 600;
          control-center-width = 500;
          control-center-margin-top = 0;
          control-center-margin-bottom = 0;
          control-center-margin-right = 0;
          control-center-margin-left = 0;

          notification-icon-size = 100;
          notification-window-width = 500;
          notification-body-image-height = 100;
          notification-body-image-width = 200;
          notification-grouping = true;
          notification-2fa-action = true;
          notification-inline-replies = false;

          timeout = 10;
          timeout-low = 5;
          timeout-critical = 0;

          fit-to-screen = true;
          keyboard-shortcuts = true;
          relative-timestamps = true;
          image-visibility = "when-available";
          transition-time = 200;
          hide-on-clear = true;
          hide-on-action = true;
          widgets = [
            "title"
            "dnd"
            "notifications"
            "mpris"
          ];
          widget-config = {
            label = {
              max-lines = 1;
              text = "Notification Center";
            };
            buttons-grid = {
              actions = [
                {
                  label = " ";
                  command = "amixer set Master toggle";
                }
                {
                  label = "󰍰";
                  command = "amixer set Capture toggle";
                }
                {
                  label = " ";
                  command = "hyprctl dispatch exec pypr toggle impala ; swaync-client -cp";
                }
                {
                  label = "󰂯";
                  command = "hyprctl dispatch exec pypr toggle bluetui ; swaync-client -cp";
                }
              ];
            };
            title = {
              text = "Notifications";
              clear-all-button = true;
              button-text = " ";
            };
            dnd = {
              text = "Do Not Disturb";
            };
            notifications = {
              vexpand = true;
            };
            mpris = {
              image-size = 96;
              image-radius = 6;
              blur = false;
              blacklist = [ "playerctld" ];
              autohide = true;
              show-album-art = "always";
              loop-carousel = false;
            };
          };
        };
      };

      mpd-mpris.enable = config.services.swaync.enable;
    };

    xdg.configFile = mkCfgLink [ "swaync/style.css" ];

    # Theme
    catppuccin.swaync.enable = false;
  };
}
