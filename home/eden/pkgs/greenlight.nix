{ appimageTools, fetchurl }:

let
  pname = "greenlight";
  version = "2.4.2";

  src = fetchurl {
    url = "https://github.com/unknownskl/greenlight/releases/download/v${version}/Greenlight-${version}.AppImage";
    hash = "sha512-LAjGubTokJqzyhg+eQIdKkH9dfRLOnAsBkYZnw+uXaj5TS5JphBwIXaJC2m/akWFWYCqClC/32RUMUvu4T03bQ==";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in

appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/*.desktop -t $out/share/applications
    cp -r ${appimageContents}/usr/share/icons $out/share

    substituteInPlace $out/share/applications/*.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = {
    description = "Open-source client for xCloud and Xbox home streaming";
    homepage = "https://github.com/unknownskl/greenlight";
    platforms = [ "x86_64-linux" ];
  };
}
