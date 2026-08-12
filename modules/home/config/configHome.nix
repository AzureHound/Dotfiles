{
  lib,
  pkgs,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkIf mkMerge;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in

{
  config = mkMerge [
    {
      xdg.configFile = mkCfgLink (
        [ ]

        ++ optionals isLinux [
          # "incus"
        ]
      );
    }

    (mkIf config.pixel.profiles.graphical.enable {
      xdg.configFile = mkCfgLink (
        [
          "goread"
          "presenterm"
          "silicon"
          "ticker"
        ]

        ++ optionals isLinux [ ]
      );
    })

    (mkIf config.pixel.profiles.development.enable {
      xdg.configFile = mkCfgLink [ ];
    })
  ];
}
