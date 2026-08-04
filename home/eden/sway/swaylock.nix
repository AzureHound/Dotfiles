{ config, ... }:

{
  programs.swaylock = {
    enable = config.programs.sway.enable;

    settings = {
      image = "~/Developer/Wallpapers/flowers.png";
      # image= "~/.config/swaylock/wallpaper";
      scaling = "fill";
      font = "JetBrainsMono Nerd Font";
      font-size = 60;

      indicator-caps-lock = true;
      indicator-x-position = 640;
      indicator-y-position = 360;
      indicator-radius = 150;
      indicator-thickness = 35;

      color = "24274a";
      bs-hl-color = "f4dbd6";
      caps-lock-bs-hl-color = "f4dbd6";
      caps-lock-key-hl-color = "a6da95";
      inside-color = "00000000";
      inside-clear-color = "00000000";
      inside-caps-lock-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";
      key-hl-color = "8bd5ca";
      layout-bg-color = "00000000";
      layout-border-color = "00000000";
      layout-text-color = "cad3f5";
      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      ring-color = "eed49f";
      ring-clear-color = "f0c6c6";
      ring-caps-lock-color = "f5a97f";
      ring-ver-color = "8aadf4";
      ring-wrong-color = "ee99a0";
      separator-color = "00000000";
      text-color = "cad3f5";
      text-clear-color = "c6a0f6";
      text-caps-lock-color = "f5a97f";
      text-ver-color = "a6da95";
      text-wrong-color = "ee99a0";
    };
  };

  # Theme
  catppuccin.swaylock.enable = false;
}
