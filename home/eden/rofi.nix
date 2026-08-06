{
  lib,
  pkgs,
  config,
  osConfig,
  mkCfgLink,
  ...
}:

let
  inherit (lib) mkIf optional;

  gaming = osConfig.pixel.profiles.gaming.enable;
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    programs.rofi = {
      enable = pkgs.stdenv.hostPlatform.isLinux;
      package = pkgs.rofi;
      plugins = optional gaming pkgs.rofi-games;

      font = "JetBrainsMono Nerd Font 10";
      terminal = "rofi-sensible-terminal";
      theme = "~/.config/rofi/style.rasi";

      extraConfig = {
        modes = "drun,run,filebrowser";
        case-sensitive = false;
        cycle = false;
        filter = "";
        scroll-method = 0;
        normalize-match = true;
        show-icons = true;
        icon-theme = "Adwaita";
        steal-focus = false;
        hover-select = true;

        kb-row-up = "Control+k,Up";
        kb-row-down = "Control+j,Down";
        kb-accept-entry = "Return,KP_Enter";
        kb-remove-to-eol = "";

        matching = "normal";
        tokenize = true;

        ssh-client = "ssh";
        ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
        parse-hosts = true;
        parse-known-hosts = true;

        drun-categories = "";
        drun-match-fields = "name,generic,exec,categories,keywords";
        drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
        drun-show-actions = false;
        drun-url-launcher = "xdg-open";
        drun-use-desktop-cache = false;
        drun-reload-desktop-cache = false;

        "drun" = {
          parse-user = true;
          parse-system = true;
        };

        run-command = "{cmd}";
        run-list-command = "";
        run-shell-command = "{terminal} -e {cmd}";

        "run,drun" = {
          fallback-icon = "application-x-addon";
        };

        window-match-fields = "title,class,role,name,desktop";
        window-command = "wmctrl -i -R {window}";
        window-format = "{w} - {c} - {t:0}";
        window-thumbnail = false;

        disable-history = true;
        sorting-method = "fzf";
        max-history-size = 25;

        display-window = "Windows";
        display-windowcd = "Window CD";
        display-run = "Run";
        display-ssh = "SSH";
        display-drun = "Apps";
        display-combi = "Combi";
        display-keys = "Keys";
        display-filebrowser = "Files";

        sort = false;
        threads = 0;
        click-to-exit = true;

        "filebrowser" = {
          directories-first = true;
          sorting-method = "name";
        };

        "timeout" = {
          action = "kb-cancel";
          delay = 0;
        };
      };
    };

    home.packages = [
      (pkgs.writeShellScriptBin "steam" ''
        if [[ "$1" == steam://* ]]; then
          exec systemd-run --user --quiet /run/current-system/sw/bin/steam "$@"
        fi

        exec /run/current-system/sw/bin/steam "$@"
      '')
    ];

    xdg.configFile = mkCfgLink (
      map (f: "rofi/${f}") [
        "style.rasi"
        "theme"
        "scripts"
      ]
      ++ optional gaming "rofi-games"
    );

    # Theme
    catppuccin.rofi.enable = false;
  };
}
