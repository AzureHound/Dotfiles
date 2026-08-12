{
  lib,
  pkgs,
  mkpkg,
  config,
  ...
}:

let
  inherit (lib.lists) optionals;
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  cfg = config.pixel.profiles;
in

{
  home.packages = with pkgs; [ ]

  ++ optionals cfg.workstation.enable [
    age
    bitwarden-cli
    curl
    file
    gitleaks
    imagemagick
    jless
    jq
    just
    mediainfo
    openssl
    ouch
    procps
    pwgen
    rsync
    speedtest-cli
    trash-cli
    unzip
    wget
    yq
    zip
  ]

  ++ optionals cfg.graphical.enable [
    asciinema
    # basalt
    calcure
    mkpkg.cbonsai
    chafa
    circumflex
    croc
    # dipc
    duf
    exiftool
    # figlet
    ghostscript
    goread
    # kanata
    # keepassxc
    libsixel
    links2
    mailsy
    # mame-tools
    # mouseless
    nodejs
    # noxdir
    # obsidian
    # otree
    # pokemon-colorscripts-mac
    presenterm
    # scrcpy
    serpl
    silicon
    socat
    spotdl
    # tgpt
    ticker
    ueberzugpp
    # vhs
  ]

  ++ optionals (cfg.graphical.enable && isLinux) [
    # android-file-transfer
    # ani-skip
    bluetui
    clamav
    # decibels
    # easyeffects
    espeak
    ffmpegthumbnailer
    # fragments
    freerdp
    gnome-calculator
    # gnome-connections
    # gnome-disk-utility
    # gnome-firmware
    # gnome-obfuscate
    grim
    # helvum
    hunspell
    # identity
    impala
    # impression
    # insomnia
    libnotify
    # libreoffice-fresh
    lowfi
    # lsp-plugins
    # minivmac
    mkpkg.mechsim
    nautilus
    nautilus-python
    packet
    # pika-backup
    # pipeline
    # plocate
    pwvucontrol
    raider
    # revanced-cli
    # rpi-imager
    slurp
    # systemctl-tui
    sysz
    tesseract
    timr-tui
    # usbutils
    unimatrix
    v4l-utils
    widevine-cdm
    wl-clipboard
    wl-gammactl

    ## iOS
    # ideviceinstaller
    # libimobiledevice
    # usbmuxd
  ]

  ++ optionals cfg.media.editing.enable [
    darktable
    gimp
    inkscape
    rapidraw
  ]

  ++ optionals cfg.media.watching.enable [
    ani-cli
    ff2mpv-rust
    # plezy
  ]

  ++ optionals (cfg.media.watching.enable && isLinux) [
    ffmpeg
    # syncplay
  ]

  ++ [
    (python313.withPackages (
      ps: with ps; [
        argcomplete
        faker
        # mutagen
        # pip
        # pipx
        # pylatexenc
        # pyopenssl
        # pytest
      ] ++ optionals isLinux [
        dbus-python
      ]
    ))
  ];
}
