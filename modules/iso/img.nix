{
  lib,
  self,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkImageMediaOverride;
  inherit (lib.sources) cleanSource;

  hostname = config.networking.hostName or "nixos";
  rev = self.shortRev or "dirty";

  # $hostname-$release-$rev-$arch
  name = "${hostname}-${config.system.nixos.release}-${rev}-${pkgs.stdenv.hostPlatform.uname.processor}";
in

{
  image = {
    baseName = mkImageMediaOverride name;
    extension = "iso";
  };

  isoImage = {
    volumeID = mkImageMediaOverride name;
    appendToMenuLabel = "";
    edition = "";

    contents = [
      {
        source = cleanSource self;
        target = "/flake";
      }
    ];
  };
}
