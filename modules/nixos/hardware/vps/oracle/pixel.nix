{ lib, config, ... }:

let
  inherit (lib.modules) mkIf mkForce;
  inherit (lib.options) mkEnableOption;
in

{
  options.pixel.profiles.oracle.enable = mkEnableOption "Oracle Cloud profile";

  config = mkIf config.pixel.profiles.oracle.enable {
    services.thermald.enable = mkForce false; # lacks thermal sensors
  };
}
