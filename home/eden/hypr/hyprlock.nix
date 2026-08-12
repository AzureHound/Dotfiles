{ self, config, ... }:

{
  programs.hyprlock = {
    inherit (config.programs.hyprland) enable;

    settings = {
      # █ █ █▄█ █▀█ █▀█ █   █▀█ █▀▀ █▄▀
      # █▀█  █  █▀▀ █▀▄ █▄▄ █▄█ █▄▄ █ █

      # NOTE: Hyprlock hasn't yet moved to lua
      # source = [ "${self}/config/configHome/hypr/theme/colors.lua" ];
      "$lavender" = "rgb(b7bdf8)";
      "$text" = "rgb(cad3f5)";
      "$subtext0" = "rgb(a5adcb)";
      "$peach" = "rgb(f5a97f)";
      "$teal" = "rgb(8bd5ca)";
      "$yellow" = "rgb(eed49f)";
      "$red" = "rgb(ed8796)";
      "$surface0" = "rgb(363a4f)";
      "$green" = "rgb(a6da95)";
      "$mauve" = "rgb(c6a0f6)";

      "$font0" = "JetBrainsMono Nerd Font";
      "$font1" = "Maple Mono";
      "$font2" = "SFProDisplay Nerd Font";

      general = {
        hide_cursor = true;
        fail_timeout = 200;
      };

      background = [
        {
          monitor = "DP-1";
          path = "~/Developer/Wallpapers/fireflies.jpg";
          # path = "~/.config/hypr/lock";
          color = "$lavender";

          blur_size = 4;
          blur_passes = 3;
          noise = 0.0117;
          contrast = 1.3000;
          brightness = 0.8000;
          vibrancy = 0.2100;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        # Lock Icon
        {
          monitor = "";
          text = "<span> </span>";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 20;
          font_family = "$font2";
          position = "1, -90";
          halign = "center";
          valign = "top";
        }

        # Date
        # {
        #   monitor = "";
        #   text = "cmd[update:18000000] echo \"<b> \"$(date +'%A, %B %d')\" </b>\"";
        #   color = "rgba(255,255,255, 0.8)";
        #   font_size = 17;
        #   font_family = "$font0";
        #   shadow_passes = 3;
        #   shadow_size = 3;
        #   position = "0, -175";
        #   halign = "center";
        #   valign = "top";
        # }

        # Time
        {
          monitor = "DP-1";
          shadow_passes = 1;
          text = "cmd[update:1000] echo \"<b><big> $(date +\"%H:%M\") </big></b>\"";
          color = "$text";
          font_size = 80;
          font_family = "$font2";
          position = "0, -54";
          halign = "center";
          valign = "center";
        }

        # Sounds
        {
          monitor = "DP-1";
          text = "cmd[update:1000] echo \"$(~/Developer/dotfiles/config/configHome/hypr/scripts/media)\"";
          shadow_passes = 1;
          color = "$subtext0";
          font_size = 16;
          font_family = "$font1";
          position = "0, -135";
          halign = "center";
          valign = "center";
        }

        # User
        # {
        #   monitor = "DP-1";
        #   text = "Hey $USER!";
        #   shadow_passes = 1;
        #   color = "$subtext0";
        #   font_size = 16;
        #   font_family = "$font0";
        #   position = "0, -596";
        #   halign = "center";
        #   valign = "center";
        # }

        # Temp
        # {
        #   monitor = "";
        #   text = "cmd[update:18000000] curl -s 'wttr.in/Agartala?format=%c%t'";
        #   color = "$subtext0";
        #   font_size = 15;
        #   font_family = "$font0";
        #   position = "0, -225";
        #   halign = "center";
        #   valign = "top";
        # }
      ];

      image = [
        # User Img
        {
          monitor = "DP-1";
          path = "~/.face";
          shadow_passes = 2;
          rounding = -1; # negative values mean circle
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        # Password Field
        {
          monitor = "DP-1";
          rounding = 50;
          shadow_passes = 2;
          size = "150, 50";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.64;
          dots_center = true;
          inner_color = "rgba(0,0,0, 0.2)";
          outer_color = "rgba(0,0,0, 0.2)";
          # inner_color = "$surface0";
          # outer_color = "$green";
          capslock_color = "$peach";
          # numlock_color = "$mauve";
          invert_numlock = false;
          bothlock_color = "$teal";
          font_color = "$lavender";
          font_family = "$font0";
          check_color = "$yellow";
          fail_color = "$red";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>";
          hide_input = false;
          position = "0, 44";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };

  # Theme
  catppuccin.hyprlock.enable = false;
}
