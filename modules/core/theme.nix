{
  lib,
  pkgs,
  config,
  options,
  ...
}:

let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in

{
  options.pixel.catppuccin.oled.enable = mkEnableOption "oled";

  config = {
    catppuccin = {
      enable = true;
      autoEnable = false;

      flavor = "macchiato";
      accent = "blue";

      sources = mkIf config.pixel.catppuccin.oled.enable (
        options.catppuccin.sources.default.overrideScope (
          _: _: {
            whiskers = pkgs.symlinkJoin {
              name = "whiskers-wrapped";

              paths = [ pkgs.catppuccin-whiskers ];
              nativeBuildInputs = [ pkgs.makeBinaryWrapper ];

              postBuild = ''
                wrapProgram $out/bin/whiskers \
                  --add-flag ${lib.strings.escapeShellArg "--color-overrides=${
                    builtins.toJSON {
                      macchiato = {
                        base = "000000";
                        mantle = "010101";
                        crust = "020202";
                      };
                    }
                  }"}
              '';

              meta.mainProgram = "whiskers";
            };
          }
        )
      );
    };
  };
}
