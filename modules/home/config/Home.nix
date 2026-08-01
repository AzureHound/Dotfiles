{
  lib,
  pkgs,
  config,
  osConfig,
  mkHomeLink,
  mkIgLink,
  ...
}:

let
  inherit (lib.modules) mkIf mkMerge;
in

{
  config = mkMerge [
    (mkIf (pkgs.stdenv.hostPlatform.isLinux && osConfig.pixel.services.docker.enable) {
      home.file = mkHomeLink [ "docker" ];
    })

    (mkIf config.pixel.profiles.graphical.enable {
      home.file = mkHomeLink [
        ".czrc"
        ".face"
        ".local/bin"
        ".local/share/fonts"
      ];

      xdg.dataFile = mkIf pkgs.stdenv.hostPlatform.isLinux (mkIgLink config.ign.desktop);
    })
  ];
}
