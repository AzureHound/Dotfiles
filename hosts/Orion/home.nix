{
  pkgs,
  mkpkg,
  mkCfgLink,
  mkScptLink,
  ...
}:

{
  pixel = {
    profiles = {
      development.enable = true;
      # pentesting.enable = true;

      media = {
        # editing.enable = true;
        listening.enable = true;
        # streaming.enable = true;
        watching.enable = true;
      };
    };
  };

  programs = {
    chromium.enable = true;
    # discord.enable = true;
    firefox.enable = true;
    # fish.enable = true;
    hyprland.enable = true;
    kitty.enable = true;
    # nushell.enable = true;
    qutebrowser.enable = true;
    thunderbird.enable = true;
    zen-browser.enable = true;
    zsh.enable = true;
  };

  services = {
    ollama.enable = true;
    syncthing.enable = true;
  };

  home.packages = with pkgs; [
    asciiquarium-transparent
    # distrobox
    # easyeffects
    hyprpicker
    # hyprpolkitagent
    liquidctl
    # lsfg-vk
    # lsfg-vk-ui
    (openrgb.withPlugins [
      # openrgb-plugin-effects
      openrgb-plugin-hardwaresync
    ])
    pipes
    pyprland
    qemu
    terminal-rain-lightning
    tty-clock
    # upscaler
    # vkbasalt
    # vscodium
    # waybar
    wl-freeze

    ## games
    # _2048-in-terminal
    # chess-tui
    mkpkg.greenlight
    # nethack
    # stockfish # Chess Engine
    # vitetris
  ];

  # Symlinks
  home.scripts = mkScptLink [
    "game-id"
    "rig"
    "spotdl-sync"
    "windows"
  ];

  xdg.configFile = mkCfgLink [
    # "lsfg-vk"
    "OpenRGB"
    "pypr"
    # "vkBasalt"
  ];
}
