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
      tempDir = "tmp_files";
      imageDisplay = {
        type = if config.programs.sway.enable then "sixel" else "kitty";
        scaleX = 9;
        scaleY = 9;
      };
      keyBindings = {
        choose = "enter";
        clearSelected = "S";
        down = "j";
        end = "G";
        filter = "/";
        forceQuit = "Q";
        home = "g";
        more = "?";
        nextPage = "l";
        prevPage = "h";
        preview = "space";
        quit = "q";
        remove = "d";
        selectDown = "shift+j";
        selectSingle = "s";
        selectUp = "shift+k";
        togglePin = "p";
        togglePinned = "tab";
        up = "k";
        yankFilter = "y";
      };
    };
  };
}
