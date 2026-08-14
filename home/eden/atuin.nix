{ config, ... }:

{
  programs.atuin = {
    inherit (config.pixel.profiles.workstation) enable;

    # flags = [ "--disable-up-arrow" ];

    settings = {
      update_check = false;
      # sync_address = "https://atuin.softshell.duckdns.org";
      # sync_frequency = "5m";
      style = "auto";
      enter_accept = true;
      keymap_mode = "vim-insert";
      sync.records = true;
      tmux = {
        enabled = true;
        width = "96%";
        height = "100%";
      };
      logs.dir = "~/.local/state/atuin";
      ai.enabled = false;
    };
  };
}
