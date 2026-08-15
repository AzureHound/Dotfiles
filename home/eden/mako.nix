{
  services.mako = {
    settings = {
      layer = "overlay";
      width = 350;
      height = 110;
      padding = "0,15,25";
      border-radius = 5;
      default-timeout = 8000;
      ignore-timeout = 1;
      font = "Maple Mono 12";

      background-color = "#24273a";
      text-color = "#cad3f5";
      border-color = "#91d7e3";
      progress-color = "over #363a4f";

      "urgency=high" = {
        border-color = "#f5a97f";
      };

      "category=mpd" = {
        default-timeout = 2000;
        group-by = "category";
      };

      "category=caffeine" = {
        format = "%b";
      };
    };
  };

  # Theme
  catppuccin.mako.enable = false;
}
