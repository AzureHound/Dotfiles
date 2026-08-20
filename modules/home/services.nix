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
  config = mkIf (config.pixel.profiles.graphical.enable && pkgs.stdenv.hostPlatform.isLinux) {
    services = {
      # cliphist.enable = true;

      polkit-gnome.enable = true;
    };
  };
}
