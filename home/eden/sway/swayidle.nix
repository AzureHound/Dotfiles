{ pkgs, config, ... }:

{
  services.swayidle = {
    enable = config.programs.sway.enable;

    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 400;
        command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
      }
      {
        timeout = 404;
        command = "${pkgs.systemd}/bin/systemctl hibernate";
      }
    ];

    events = {
      before-sleep = "${pkgs.playerctl}/bin/playerctl pause; ${pkgs.swaylock}/bin/swaylock -f";
    };
  };
}
