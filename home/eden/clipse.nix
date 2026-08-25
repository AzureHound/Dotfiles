{ pkgs, config, ... }:

{
  services.clipse = {
    enable = pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable;

    settings = {
      allowDuplicates = false;
      maxHistory = 1000;
      historyFile = "clipboard_history.json";
      logFile = "clipse.log";
      themeFile = "custom_theme.json";
      tempDirPath = "tmp_files";
      imageDisplay = {
        type = if config.programs.sway.enable then "sixel" else "kitty";
        scaleX = 9;
        scaleY = 9;
      };
      keyBindings = {
        choose = "enter";
        clearAll = "ctrl-l";
        down = "down";
        end = "end";
        filter = "/";
        home = "home";
        more = "?";
        nextPage = "right";
        pageDown = "pgdown";
        pageUp = "pgup";
        prevPage = "left";
        quit = "q";
        remove = "delete";
        selectDown = "ctrl-down";
        selectSingle = "ctrl-s";
        selectUp = "ctrl-up";
        togglePin = "p";
        togglePinned = "tab";
        up = "up";
        yank = "y";
      };
    };
  };
}
