{
  lib,
  self,
  pkgs,
  _class,
  config,
  ...
}:

let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    fonts.packages =
      with pkgs;
      [
        corefonts

        source-sans
        source-serif

        dejavu_fonts
        inter

        noto-fonts

        noto-fonts-cjk-sans
        noto-fonts-cjk-serif

        noto-fonts-color-emoji
        material-icons
        material-design-icons
        twemoji-color-font

        maple-mono.truetype
      ]

      ++ (with pkgs.nerd-fonts; [
        jetbrains-mono
        symbols-only
      ])

      ++ optionals (_class == "nixos") [
        (stdenvNoCC.mkDerivation {
          name = "pixelon";
          src = "${self}/config/home/.local/share/fonts/pixelon.regular.ttf";
          dontUnpack = true;
          installPhase = ''
            mkdir -p $out/share/fonts/truetype
            cp $src $out/share/fonts/truetype/pixelon.regular.ttf
          '';
        })
      ];
  };
}
