{ lib, config, ... }:

let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.modules) mkIf mkForce;
in

{
  config = mkIf config.pixel.profiles.headless.enable {
    environment.variables.BROWSER = "echo";

    fonts = mapAttrs (_: mkForce) {
      packages = [ ];
      fontDir.enable = false;
      fontconfig.enable = false;
    };

    services.udisks2.enable = mkForce false;

    xdg = mapAttrs (_: mkForce) {
      autostart.enable = false;
      icons.enable = false;
      menus.enable = false;
      mime.enable = false;
      sounds.enable = false;
    };

    # https://github.com/numtide/srvos/blob/main/nixos/server/default.nix
    systemd = {
      enableEmergencyMode = false;

      # https://0pointer.de/blog/projects/watchdog.html
      settings.Manager = {
        RuntimeWatchdogSec = "20s";

        # https://utcc.utoronto.ca/~cks/space/blog/linux/SystemdShutdownWatchdog
        RebootWatchdogSec = "30s";
      };

      sleep.settings.Sleep = {
        AllowSuspend = false;
        AllowHibernation = false;
      };

      services = {
        "serial-getty@ttyS0".enable = lib.modules.mkDefault false;
        "serial-getty@hvc0".enable = false;
        "getty@tty1".enable = false;
        "autovt@".enable = false;
      };
    };
  };
}
