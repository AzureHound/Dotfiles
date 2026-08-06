{ lib, ... }:

{
  services.caffeine.enable = true;

  systemd.user.services.caffeine.Install.WantedBy = lib.mkForce [ ];
}
