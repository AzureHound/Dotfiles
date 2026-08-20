{
  lib,
  pkgs,
  config,
  mkScptLink,
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
      home.scripts = mkScptLink (
        [
          # "sysgrade"
        ]

        ++ optionals isLinux [ ]
      );
    }

    (mkIf config.pixel.profiles.graphical.enable {
      home.scripts = mkScptLink (
        [
          "fontpreview"
        ]

        ++ optionals isLinux [
          "caffeine"
          "emoji"
          "glyph"
          "hidpi"
          "mechsounds"
          "rip"
          "sounds"
        ]
      );
    })

    (mkIf config.pixel.profiles.development.enable {
      home.scripts = mkScptLink [
        # "installCodiumExtensions"
      ];
    })
  ];
}
