{
  lib,
  pkgs,
  config,
  mkHomeLink,
  mkCfgLink,
  ...
}:

let
  inherit (lib.modules) mkIf;

  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in

{
  config = mkIf config.pixel.profiles.workstation.enable {
    programs.tmux = {
      enable = true;

      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";

      prefix = "C-Space";
      keyMode = "vi";
      mouse = true;

      baseIndex = 1;
      aggressiveResize = true;
      clock24 = true;

      escapeTime = 0;
      historyLimit = 100000;

      plugins = with pkgs.tmuxPlugins; [ vim-tmux-navigator ];

      tmuxp.enable = true;

      extraConfig = ''
        set-option -sa terminal-overrides ",xterm-256color:RGB"
        set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
        set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

        set-option -g renumber-windows 1
        set-option -g lock-after-time 3600
        set-window-option -g xterm-keys on

        set -g status on
        set -g set-titles on
        set -g bell-action any
        set -g focus-events on
        set -g extended-keys on
        set -g set-clipboard on
        set -g status-interval 1
        set -g lock-command vlock
        set -g visual-activity off
        set -g allow-passthrough on
        set -g detach-on-destroy off
        set -g extended-keys-format csi-u
        set -ga update-environment TERM_PROGRAM

        source-file ~/.config/tmux/theme.conf
        source-file ~/.config/tmux/binds.conf
      '';
    };

    home = {
      packages =
        with pkgs;
        [
          gitmux
        ]
        ++ lib.optionals isLinux [ vlock ];

      file = mkHomeLink [ ".gitmux.conf" ];

      shellAliases = {
        mail = "tmuxp load -y mail";
        notes = "tmuxp load -y notes";
      };
    };

    xdg.configFile = mkCfgLink (
      map (f: "tmux/${f}") [
        "theme.conf"
        "binds.conf"
        "scripts"
      ]
      ++ [
        "tmuxp"
      ]
    );

    # Theme
    catppuccin.tmux.enable = false;
  };
}
