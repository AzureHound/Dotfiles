{ pkgs, ... }:

let
  pkg = file: pkgs.callPackage file { };
in

{
  banana-cursor = pkg ./banana-cursor.nix;
  cbonsai = pkg ./cbonsai.nix;
  greenlight = pkg ./greenlight.nix;
  mechsim = pkg ./mechsim.nix;
  swaync = pkg ./swaync.nix;
}
