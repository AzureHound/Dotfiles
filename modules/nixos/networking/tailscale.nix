{
  lib,
  self,
  name,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.types)
    enum
    listOf
    str
    nullOr
    ;

  inherit (config.services) tailscale;
  inherit (self.lib) mkSecret;

  cfg = config.pixel.system.networking.tailscale;
in

{
  options.pixel.system.networking.tailscale = {
    enable = mkEnableOption "Tailscale VPN" // {
      default = true;
    };

    exitNode = mkOption {
      type = nullOr str;
      default = null;
    };

    lan = mkOption {
      type = listOf str;
      default = [ "10.10.0.0/24" ];
    };

    mode = mkOption {
      type = enum [
        "client"
        "server"
      ];
      default = "client";
    };
  };

  config = mkIf cfg.enable {
    sops.secrets.tailscale = mkSecret { file = "tailscale"; };

    networking.firewall = {
      trustedInterfaces = [ "${tailscale.interfaceName}" ];
      checkReversePath = "loose";
    };

    services.tailscale = {
      enable = true;
      permitCertUid = "root";
      openFirewall = true;
      useRoutingFeatures = if cfg.mode == "server" then "both" else "client";
      authKeyFile = config.sops.secrets.tailscale.path;
      extraUpFlags = [
        "--operator=${name}"
      ]
      ++ lib.optional (cfg.exitNode != null) "--exit-node=${cfg.exitNode}"
      ++ lib.optional (cfg.mode == "client") "--accept-routes=true"
      ++ lib.optional (cfg.mode == "server") "--advertise-exit-node"
      ++ lib.optional (cfg.mode == "server" && cfg.lan != [ ]) "--advertise-routes=${concatStringsSep "," cfg.lan}";
    };
  };
}
