{ pkgs, ... }:

{
  systemd.user.services.caffeine = {
    Service = {
      ExecStart = "${pkgs.systemd}/bin/systemd-inhibit --why='Caffeine mode' --what=sleep:shutdown:idle ${pkgs.coreutils}/bin/sleep infinity";
      Type = "exec";
      Restart = "no";
    };
  };
}
