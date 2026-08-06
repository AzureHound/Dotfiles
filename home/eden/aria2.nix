{ config, ... }:

{
  programs.aria2 = {
    inherit (config.pixel.profiles.workstation) enable;
    systemd.enable = true;

    settings = {
      dir = "${config.home.homeDirectory}/Downloads";
      listen-port = 60000;
      dht-listen-port = 60000;
      seed-ratio = 1.0;
      max-upload-limit = "50K";
      ftp-pasv = true;
    };
  };
}
