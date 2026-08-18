{
  lib,
  pkgs,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in

{
  config = mkIf config.pixel.profiles.media.watching.enable {
    programs.mpv = {
      enable = true;

      scripts =
        with pkgs.mpvScripts;
        [
          sponsorblock
          modernz
          # mpv-image-viewer.image-positioning
          thumbfast
        ]

        ++ lib.lists.optionals isLinux [
          mpris
        ];

      config = {
        # THEME
        background-color = "#24273a";
        osd-back-color = "#6e738d";
        osd-border-color = "#181926";
        osd-color = "#cad3f5";
        osd-shadow-color = "#24273a";
        sub-color = "#eed49f";

        # OSD
        osd-bar = "yes";
        # osd-scale= "0.5";
        osd-font = "Maple Mono";
        osd-font-size = 35;
        term-osd-bar = "yes";

        # OPTIONS
        osc = "no";
        border = "no";
        msg-color = "yes";
        msg-module = "yes";
        save-watch-history = "yes";
        save-position-on-quit = "yes";
        watch-later-options-remove = "sub-pos";
        keep-open = "no";
        cursor-autohide = 100;
        stop-screensaver = "yes";
        reset-on-next-file = "video-zoom,panscan,video-unscaled,video-rotate,video-align-x,video-align-y";

        # VIDEO & RENDERING
        # Linux: auto-copy/vulkan | Darwin: auto/auto
        hwdec = if isLinux then "auto-copy" else "auto";
        gpu-api = if isLinux then "vulkan" else "auto";
        profile = "gpu-hq"; # Can cause performance problems with some GPU drivers & GPUs
        vo = "gpu-next"; # https://github.com/mpv-player/mpv/wiki/GPU-Next-vs-GPV

        # SCREENSHOTS
        screenshot-directory = "~/Pictures/screenshots";
        screenshot-template = "screenshot-%F-T%wH.%wM.%wS.%wT-F%{estimated-frame-number}";
        # screenshot-template= "mpv-%f-%p";
        screenshot-format = "png";
        screenshot-png-compression = 4; # Range is 0 to 10. 0 being no compression.
        screenshot-tag-colorspace = "yes";
        screenshot-high-bit-depth = "yes";

        # CACHE
        cache = "yes";
        cache-secs = 300;
        demuxer-max-bytes = "1800M";
        demuxer-max-back-bytes = "1200M";

        # AUDIO & SUBTITLES
        af = if isLinux then "dynaudnorm=g=5:f=250:r=0.9:p=0.5" else "";
        volume = 70;
        volume-max = 200;
        alang = "en,jpn,jp";
        slang = "eng,en";
        vlang = "en,eng,jpn";
        blend-subtitles = "yes";
        sub-scale = 1;
        sub-font = "JetBrainsMono Nerd Font";
        # sub-font-size= 45;

        # ANTI-RINGING
        scale-antiring = 0.7; # luma upscale deringing
        dscale-antiring = 0.7; # luma downscale deringing
        cscale-antiring = 0.7; # chroma upscale deringing

        # DEBANDING
        deband-iterations = 4;
        deband-threshold = 48;
        deband-range = 16;
        deband-grain = 48;

        # MOTION INTERPOLATION
        # override-display-fps = 60;
        video-sync = if isLinux then "display-resample" else "audio";
        # interpolation = "yes";
        # tscale = "oversample"; # smoothmotion

        # UPSCALING & PROCESSING
        # NOTE: Any FSRCNNX above FSRCNNX_x2_8-0-4-1 is not worth the additional computational overhead
        # ssimdownscaler is tuned for mitchell & downscaling=no
        glsl-shaders =
          if isLinux then
            "~~/shaders/FSRCNNX_x2_8-0-4-1.glsl:~~/shaders/SSimDownscaler.glsl:~~/shaders/KrigBilateral.glsl"
          else
            "";
        scale = "ewa_lanczos";
        dscale = "mitchell";
        cscale = "mitchell";
        linear-downscaling = "no";
        sigmoid-upscaling = "yes";

        # YouTube
        ytdl-raw-options = "cookies=~/documents/yt-dlp-cookies.txt";

        # PROFILE RESTORE
        profile-restore = "copy-equal";
      };

      profiles = {
        "extension.gif" = {
          profile-restore = "copy-equal";
          cache = "no";
          pause = "no";
          loop-file = "yes";
          glsl-shaders = "";
          deband = "no";
        };

        "extension.webm" = {
          profile-restore = "copy-equal";
          pause = "no";
          loop-file = "yes";
          glsl-shaders = "";
          deband = "no";
        };
      };
    };

    xdg.configFile =
      mkCfgLink (
        map (f: "mpv/${f}") [
          "input.conf"
          "script-opts"
          "shaders"
        ]
      )
      // {
        "mpv/fonts/modernz-icons.ttf".source = pkgs.fetchurl {
          url = "https://github.com/Samillion/ModernZ/raw/main/modernz-icons.ttf";
          hash = "sha256-UDO4TVaVAlOJaMbyOwhZvaeQ7thcEOQZsHWVN+xgoBY=";
        };
      };

    # Theme
    catppuccin.mpv.enable = false;
  };
}
