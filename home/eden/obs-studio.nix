{ pkgs, config, ... }:

{
  programs.obs-studio = {
    inherit (config.pixel.profiles.media.streaming) enable;

    package = pkgs.pkgsCuda.obs-studio;

    plugins = with pkgs.pkgsCuda.obs-studio-plugins; [
      wlrobs
      obs-multi-rtmp
      obs-move-transition
      obs-pipewire-audio-capture
    ];
  };

  # Theme
  catppuccin.obs.enable = true;
}
