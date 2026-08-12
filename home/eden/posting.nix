{ config, ... }:

{
  programs.posting = {
    inherit (config.pixel.profiles.development) enable;

    settings = {
      theme = "catppuccin-macchiato";
    };
  };
}
