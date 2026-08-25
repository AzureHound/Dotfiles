{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf (pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.media.listening.enable) {
    services = {
      mpd = {
        enable = true;

        extraConfig = ''
          auto_update "yes"
          restore_paused "yes"

          audio_output {
            type "pipewire"
            name "PipeWire Sound Server"
          }

          decoder {
            plugin  "wildmidi"
            enabled "no"
          }

          audio_output {
            type   "fifo"
            name   "my_fifo"
            path   "/tmp/mpd.fifo"
            format "44100:16:2"
          }
        '';
      };

      playerctld = {
        enable = true;
      };

    };

    home.packages = with pkgs; [ mpc ];

    xdg.configFile."mpd/mpd.conf".text = config.services.mpd.generatedConfig;
  };
}
