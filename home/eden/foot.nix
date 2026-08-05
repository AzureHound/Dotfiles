{ pkgs, ... }:

{
  programs.foot = {
    server.enable = true;

    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12.9, Noto Color Emoji:size=12.9";
        # font = "Maple Mono:size=13, Noto Color Emoji:size=13";
        # font-size-adjustment = 0.5;

        term = "xterm-256color";
        shell = "${pkgs.zsh}/bin/zsh";
        pad = "10x9";
        # initial-window-size-chars = "80x24";
        resize-delay-ms = 100;
        # selection-target = "clipboard";
        bold-text-in-bright = "palette-based";
        box-drawings-uses-font-glyphs = "no";
        dpi-aware = "yes";
      };

      cursor = {
        style = "beam";
        blink = "yes";
        blink-rate = 800;
        beam-thickness = 2;
      };

      mouse = {
        hide-when-typing = "yes";
        alternate-scroll-mode = "yes";
      };

      scrollback = {
        lines = 10000;
        multiplier = 3.0;
        indicator-position = "relative";
      };

      url = {
        launch = "xdg-open \${url}";
      };

      key-bindings = {
        spawn-terminal = "Control+Shift+n";
        search-start = "Control+Shift+slash";
        show-urls-launch = "Control+Shift+l";

        clipboard-copy = "Control+Shift+c";
        clipboard-paste = "Control+Shift+v";

        font-increase = "Control+Shift+plus Control+Shift+equal Control+Shift+KP_Add";
        font-decrease = "Control+Shift+minus Control+Shift+KP_Subtract";
        font-reset = "Control+Shift+BackSpace";

        scrollback-up-line = "Control+Shift+Up";
        scrollback-down-line = "Control+Shift+Down";
        scrollback-up-page = "Control+Shift+k";
        scrollback-down-page = "Control+Shift+j";
        scrollback-home = "Control+Shift+Home";
        scrollback-end = "Control+Shift+End";
      };

      search-bindings = {
        find-prev = "Control+p";
        find-next = "Control+n";
      };

      mouse-bindings = {
        scrollback-up-mouse = "BTN_WHEEL_BACK";
        scrollback-down-mouse = "BTN_WHEEL_FORWARD";
        font-increase = "Control+BTN_WHEEL_BACK";
        font-decrease = "Control+BTN_WHEEL_FORWARD";
      };

      bell = {
        urgent = "yes";
        notify = "yes";
        # visual = "yes";
        # command = "";
        command-focused = "no";
      };

      desktop-notifications = {
        command = "notify-send --wait --app-name \${app-id} --icon \${app-id} --category \${category} --urgency \${urgency} --expire-time \${expire-time} --hint STRING:image-path:\${icon} --hint BOOLEAN:suppress-sound:\${muted} --hint STRING:sound-name:\${sound-name} --replace-id \${replace-id} \${action-argument} --print-id -- \${title} \${body}";
        # command = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        command-action-argument = "--action \${action-name}=\${action-label}";
        close = "\"\"";
        inhibit-when-focused = "yes";
      };
    };
  };
}
