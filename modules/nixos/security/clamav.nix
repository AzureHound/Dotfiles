{
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    scanner = {
      enable = true;
      interval = "*-*-10 00:00:00";
    };
  };
}
