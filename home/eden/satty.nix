{ pkgs, config, ... }:

{
  programs.satty = {
    enable = pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable;

    settings = {
      general = {
        fullscreen = false;
        resize = {
          mode = "smart";
        };
        floating-hack = true;
        early-exit = true;
        # early-exit-save-as = true;
        corner-roundness = 80;
        initial-tool = "brush";
        copy-command = "wl-copy";
        annotation-size-factor = 2;
        output-filename = "/tmp/test-%Y-%m-%d_%H:%M:%S.png";
        save-after-copy = false;
        default-hide-toolbars = false;
        focus-toggles-toolbars = false;
        primary-highlighter = "block";
        disable-notifications = false;
        actions-on-right-click = [ ];
        actions-on-enter = [ "save-to-clipboard" ];
        actions-on-escape = [ "exit" ];
        no-window-decoration = true;
        brush-smooth-history-size = 10;
        zoom-factor = 1.1;
        input-scale = 2.0;
      };

      font = {
        family = "Josefin Sans";
        style = "Regular";
      };

      color-palette = {
        palette = [
          "#8aadf4"
          "#ed8796"
          "#a6da95"
          "#eed49f"
          "#c6a0f6"
          "#cad3f5"
        ];
      };
    };
  };
}
