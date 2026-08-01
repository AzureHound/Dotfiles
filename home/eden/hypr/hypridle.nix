{ config, ... }:

let
  term = config.pixel.programs.defaults.terminal;
in

{
  services.hypridle = {
    enable = config.programs.hyprland.enable;

    settings = {
      # █ █  █▄█  █▀█  █▀█  █ █▀▄ █   █▀▀
      # █▀█   █   █▀▀  █▀▄  █ █▄▀ █▄▄ ██▄

      "$scripts" = "$HOME/.config/hypr/scripts";

      "$screensaver" = "pidof hyprlock || $scripts/screensaver";

      "$lock_cmd" = "pidof hyprlock || hyprlock";
      "$suspend_cmd" = "systemctl suspend || loginctl suspend";

      general = {
        lock_cmd = "$lock_cmd";
        before_sleep_cmd = "$lock_cmd";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        on_lock_cmd = "pkill -f \"${term} --class screensaver\"";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
      };

      listener = [
        # Screensaver
        {
          timeout = 600; # 10 min
          on-timeout = "$screensaver";
        }

        # Screenlock
        {
          timeout = 1200; # 20 min
          on-timeout = "loginctl lock-session";
        }

        # Suspend
        {
          timeout = 10800; # 3 hour
          on-timeout = "$suspend_cmd";
        }
      ];
    };
  };
}
