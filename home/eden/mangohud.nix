{ pkgs, osConfig, ... }:

{
  programs.mangohud = {
    enable = osConfig.pixel.profiles.gaming.enable && pkgs.stdenv.hostPlatform.isLinux;

    settings = {
      legacy_layout = false;

      cpu_stats = true;
      cpu_temp = true;
      cpu_load_color = [
        "CAD3F5"
        "F5A97F"
        "ED8796"
      ];

      gpu_stats = true;
      gpu_temp = true;
      gpu_load_color = [
        "CAD3F5"
        "F5A97F"
        "ED8796"
      ];
      throttling_status = true;

      ram = true;
      vram = true;

      fps = true;
      fps_limit = 120;
      fps_limit_method = "early";
      fps_color_change = [
        "ED8796"
        "EED49F"
        "A6DA95"
      ];

      font_size = 22;
      # font_file = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNerdFont-Bold.ttf";

      # text_outline = true;
      text_outline_color = "363A4F";

      round_corners = 6;
      position = "top-left";
      background_alpha = 0.8;

      # width = 0;
      # height = 140;
      table_columns = 3;

      text_color = "B7BDF8";
      cpu_color = "8AADF4";
      gpu_color = "A6DA95";
      ram_color = "F5A97F";
      vram_color = "8BD5CA";
      engine_color = "ED8796";
      background_color = "24273A";

      toggle_hud = "Shift_L+F1";
    };
  };

  # Theme
  catppuccin.mangohud.enable = false;
}
