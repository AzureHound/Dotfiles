{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf mkForce;
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  appsToAssoc = {
    browser = {
      app = "firefox";
      mimeTypes = [
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-xht"
        "application/xhtml+xml"
        "text/html"
        "x-scheme-handler/about"
        "x-scheme-handler/chrome"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/ftp"
        "x-scheme-handler/unknown"
        "x-www-browser"
      ];
    };

    code = {
      app = "nvim";
      mimeTypes = [
        "application/json"
        "application/x-shellscript"
        "text/english"
        "text/plain"
        "text/x-c"
        "text/x-c++"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-makefile"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
      ];
    };

    audio = {
      app = "org.gnome.Decibels";
      mimeTypes = [ "audio/mpeg" ];
    };

    images = {
      app = "swayimg";
      mimeTypes = [
        "image/*"
        "image/avif"
        "image/bmp"
        "image/farbfeld"
        "image/gif"
        "image/heic"
        "image/heif"
        "image/jpeg"
        "image/jpg"
        "image/jxl"
        "image/png"
        "image/qoi"
        "image/sixel"
        "image/svg+xml"
        "image/tiff"
        "image/webp"
        "image/x-bmp"
        "image/x-canon-cr2"
        "image/x-canon-crw"
        "image/x-exr"
        "image/x-fuji-raf"
        "image/x-nikon-nef"
        "image/x-portable-anymap"
        "image/x-portable-bitmap"
        "image/x-portable-graymap"
        "image/x-portable-pixmap"
        "image/x-qoi"
        "image/x-tga"
        "application/dicom"
      ];
    };

    media = {
      app = "mpv";
      mimeTypes = [
        "audio/*"
        "video/*"
        "video/mp4"
        "video/quicktime"
        "video/webm"
        "video/x-matroska"
      ];
    };

    fileManager = {
      app = "org.gnome.Nautilus";
      mimeTypes = [ "inode/directory" ];
    };

    pdf = {
      app = "org.pwmt.zathura-pdf-mupdf";
      mimeTypes = [ "application/pdf" ];
    };
  };

  associations' = lib.concatMapAttrs (
    _: val: lib.listToAttrs (lib.map (mt: lib.nameValuePair mt "${val.app}.desktop") val.mimeTypes)
  ) appsToAssoc;

  specifics = {
    "x-scheme-handler/spotify" = [ "spotify.desktop" ];
    "x-scheme-handler/steam" = [ "steam.desktop" ];
  };

  associations = associations' // specifics;

  cfg = config.xdg;
in

{
  home.preferXdgDirectories = true;

  xdg = {
    enable = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    userDirs = {
      enable = isLinux && config.pixel.profiles.workstation.enable;
      createDirectories = true;
      setSessionVariables = true;

      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      projects = "${config.home.homeDirectory}/Projects";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Templates";
      videos = "${config.home.homeDirectory}/Videos";

      extraConfig = {
        SCREENSHOTS = "${config.xdg.userDirs.pictures}/screenshots";
        DEV = "${config.home.homeDirectory}/Developer";
      };
    };

    mime.enable = isLinux && !config.pixel.profiles.headless.enable;

    mimeApps = {
      enable = isLinux;
      associations.added = associations;
      defaultApplications = associations;
    };

    portal.enable = mkForce false;
  };

  home.sessionVariables = {
    # desktop
    ERRFILE = "${cfg.cacheHome}/X11/xsession-errors";
    XCOMPOSECACHE = "${cfg.cacheHome}/X11/xcompose";

    # programs
    FFMPEG_DATADIR = "${cfg.configHome}/ffmpeg";
    GNUPGHOME = "${cfg.dataHome}/gnupg";
    INPUTRC = "${cfg.configHome}/readline/inputrc";
    LESSHISTFILE = "${cfg.dataHome}/less/history";
    STEPPATH = "${cfg.dataHome}/step";
    WGETRC = "${cfg.configHome}/wget/wgetrc";
    WINEPREFIX = "${cfg.dataHome}/wine";

    # programming
    ANDROID_HOME = "${cfg.dataHome}/android";
    ANDROID_USER_HOME = "${cfg.dataHome}/android";
    CARGO_HOME = "${cfg.dataHome}/cargo";
    CUDA_CACHE_PATH = "${cfg.cacheHome}/nv";
    DOCKER_CONFIG = "${cfg.configHome}/docker";
    DOTNET_CLI_HOME = "${cfg.dataHome}/dotnet";
    GOMODCACHE = "${cfg.cacheHome}/go/pkg/mod";
    GOPATH = "${cfg.dataHome}/go";
    GRADLE_USER_HOME = "${cfg.dataHome}/gradle";
    M2_HOME = "${cfg.dataHome}/m2";
    MYSQL_HISTFILE = "${cfg.dataHome}/mysql/mysql_history";
    NODE_REPL_HISTORY = "${cfg.dataHome}/node_repl_history";
    NUGET_PACKAGES = "${cfg.cacheHome}/NuGetPackages";
    PNPM_HOME = "${cfg.dataHome}/pnpm";
    PYENV_ROOT = "${cfg.dataHome}/pyenv";
    PYTHON_HISTORY = "${cfg.dataHome}/python/python_history";
    RUSTUP_HOME = "${cfg.dataHome}/rustup";
    SQLITE_HISTORY = "${cfg.dataHome}/sqlite_history";
    WORKON_HOME = "${cfg.dataHome}/virtualenvs";
  };

  xdg = {
    configFile = {
      "python/pythonrc".text = ''
        # vim: ft=python

        import os
        import atexit
        import readline
        from pathlib import Path

        if readline.get_current_history_length() == 0:
          state_home = os.environ.get("state")
          if state_home is None:
            state_home = Path.home() / ".local" / "state"
          else:
            state_home = Path(state_home)

          history_path = state_home / "python_history"
          if history_path.is_dir():
            raise OSError(f"'{history_path}' cannot be a directory")

          history = str(history_path)

          try:
            readline.read_history_file(history)
          except OSError: # Non existent
            pass

          def write_history():
            try:
              readline.write_history_file(history)
            except OSError:
              pass

          atexit.register(write_history)
      '';

      "wget/wgetrc".text = ''
        dir_prefix = ~/Downloads

        tries = 5
        timeout = 30
        noclobber = on
        passive_ftp = on

        # verbose = on
        # recursive = on
        # background = on
        # user_agent = Mozilla/5.0 (X11; Linux x86_64)

        hsts-file = ~/.local/state/wget/history
      '';

      "xdg-desktop-portal-termfilechooser/config".text = ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
        default_dir=${config.home.homeDirectory}
        ; create_help_file=0
        env=TERMCMD='${pkgs.kitty}/bin/kitty -T "terminal filechooser"'

        ; Mode must be one of 'suggested', 'default', or 'last'.
        open_mode=suggested
        save_mode=suggested
      '';
    };

    desktopEntries = mkIf isLinux {
      qvidcap = {
        name = "Qt V4L2 video capture utility";
        noDisplay = true;
      };
      qv4l2 = {
        name = "Qt V4L2 test Utility";
        noDisplay = true;
      };

      "syncthing-ui" = {
        name = "Syncthing Web UI";
        noDisplay = true;
      };
    };
  };
}
