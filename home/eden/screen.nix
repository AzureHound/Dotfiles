{ config, ... }:

{
  programs.screen = {
    inherit (config.pixel.profiles.headless) enable;

    screenrc = ''
      altscreen on
      term screen-256color
      bind ',' prev
      bind '.' next
    '';
  };
}
