{ pkgs, ... }:

{
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    scanner = {
      enable = true;
      interval = "*-*-10 00:00:00";
    };
  };

  systemd.user = {
    services.clamav-notify = {
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.libnotify}/bin/notify-send 'ClamAV' 'Scan starts in 2 minutes'";
      };
    };

    timers.clamav-notify = {
      wantedBy = [ "timers.target" ];
      timerConfig.OnCalendar = "*-*-09 23:58:00";
    };
  };
}
