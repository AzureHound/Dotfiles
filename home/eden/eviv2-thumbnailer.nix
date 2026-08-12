{ lib, pkgs, ... }:

let
  exiv2-thumbnailer = pkgs.writeShellApplication {
    name = "exiv2-thumbnailer";
    runtimeInputs = with pkgs; [
      exiv2
      imagemagick
    ];
    text = ''
      tmpdir="$(mktemp -d)"
      trap 'rm -rf "$tmpdir"' EXIT

      exiv2 -l "$tmpdir" --extract p1 "$1"

      base="$(basename "$1")"
      preview="$tmpdir/''${base%.*}-preview1.jpg"
      [ ! -f "$preview" ] && preview="''${preview%.*}.tif"

      [ ! -f "$preview" ] && exit 1

      magick "$preview" -thumbnail "''${3}x''${3}>" -strip "png:$2"
    '';
  };
in

{
  home.packages = [ exiv2-thumbnailer ];

  xdg.dataFile."thumbnailers/exiv2raw.thumbnailer".text = ''
    [Thumbnailer Entry]
    TryExec=${lib.getExe exiv2-thumbnailer}
    Exec=${lib.getExe exiv2-thumbnailer} %i %o %s
    MimeType=image/x-3fr;image/x-adobe-dng;image/x-arw;image/x-bay;image/x-canon-cr2;image/x-canon-cr3;image/x-canon-crw;image/x-cap;image/x-cr2;image/x-crw;image/x-dcr;image/x-dcraw;image/x-dcs;image/x-dng;image/x-drf;image/x-eip;image/x-erf;image/x-fff;image/x-fuji-raf;image/x-iiq;image/x-k25;image/x-kdc;image/x-mef;image/x-minolta-mrw;image/x-mos;image/x-mrw;image/x-nef;image/x-nikon-nef;image/x-nrw;image/x-olympus-orf;image/x-orf;image/x-panasonic-raw;image/x-pef;image/x-pentax-pef;image/x-ptx;image/x-pxn;image/x-r3d;image/x-raf;image/x-raw;image/x-rw2;image/x-rwl;image/x-rwz;image/x-sigma-x3f;image/x-sony-arw;image/x-sony-sr2;image/x-sony-srf;image/x-sr2;image/x-srf;image/x-x3f;image/x-panasonic-rw2;
  '';
}
