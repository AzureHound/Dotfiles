{ lib, ... }:

let
  inherit (lib.attrsets) genAttrs concatMapAttrs;
  inherit (lib.modules) mkForce;

  # ethernetDevices = [
  #   "enp7s0"
  # ];
in

{
  services.resolved = {
    enable = true;

    settings.Resolve = {
      DNSSEC = "allow-downgrade";
      Domains = [ "~." ];
      FallbackDNS = [
        "9.9.9.9#dns.quad9.net"
        "149.112.112.112#dns.quad9.net"
        "2620:fe::fe#dns.quad9.net"
        "2620:fe::9#dns.quad9.net"
      ];
      DNSOverTLS = "yes";
      LLMNR = "false";
    };
  };

  systemd = {
    network.wait-online.enable = false;

    services = {
      # https://github.com/systemd/systemd/blob/e1b45a756f71deac8c1aa9a008bd0dab47f64777/NEWS#L13
      NetworkManager-wait-online.enable = false;

      systemd-networkd.stopIfChanged = false;
      systemd-resolved.stopIfChanged = false;
    }
    # // concatMapAttrs (_: v: v) (
    #   genAttrs ethernetDevices (device: {
    #     "network-addresses-${device}".wantedBy = mkForce [ "sys-subsystem-net-devices-${device}.device" ];
    #   })
    # )
    ;
  };
}
