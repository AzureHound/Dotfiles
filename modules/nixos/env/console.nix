{ lib, pkgs, ... }:

let
  inherit (lib.modules) mkDefault;
in

{
  console = {
    enable = mkDefault true;
    earlySetup = true;

    keyMap = "en";
    font = "${pkgs.kbd}/share/consolefonts/LatArCyrHeb-19.psfu.gz";
  };
}
