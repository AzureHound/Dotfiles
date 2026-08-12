{ config, ... }:

{
  services.hyprsunset = {
    inherit (config.programs.hyprland) enable;

    settings = {
      # "max-gamma" = 150;

      profile = [
        {
          time = "07:00";
          identity = true;
        }
        {
          time = "17:00";
          temperature = 4600;
        }
        {
          time = "20:00";
          temperature = 4000;
        }
      ];
    };
  };
}
