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
  config = mkIf (pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable) {
    services = {
      # cliphist.enable = true;

      polkit-gnome.enable = true;
    };
  };
}
