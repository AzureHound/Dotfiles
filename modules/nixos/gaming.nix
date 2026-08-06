{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.profiles.gaming;
in

{
  options.pixel.profiles.gaming.enable = mkEnableOption "Gaming profile";

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.millennium.overlays.default ];

    hardware.xone.enable = true; # Xbox Controller

    # Perf Tweaks
    boot = {
      kernelModules = [ "ntsync" ];

      kernel.sysctl = {
        "kernel.sched_autogroup_enabled" = 0;
        "kernel.sched_cfs_bandwidth_slice_u" = 3000;
        "kernel.sched_latency_ns" = 3000000;
        "kernel.sched_migration_cost_ns" = 50000;
        "kernel.sched_min_granularity_ns" = 300000;
        "kernel.sched_nr_migrate" = 128;
        "kernel.sched_wakeup_granularity_ns" = 500000;
        "kernel.split_lock_mitigate" = 0;

        "vm.dirty_background_ratio" = 5;
        "vm.dirty_ratio" = 10;
        "vm.swappiness" = 10;
      };
    };

    programs = {
      gamemode = {
        enable = true;
        enableRenice = true;

        settings = {
          general = {
            reaper_freq = 5;
            desiredgov = "performance";
            desiredprof = "performance";
            softrealtime = "auto";
            renice = 10;
            ioprio = 0;
            inhibit_screensaver = 1;
            disable_splitlock = 1;
          };

          # gpu = {
          #   apply_gpu_optimisations = "accept-responsibility";
          #   gpu_device = 0;
          #   amd_performance_level = "high";
          # };

          # custom = {
          #   start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          #   end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
          # };
        };
      };

      steam = {
        enable = true;

        extest.enable = true; # X11 → uinput
        # protontricks.enable = true;

        package = pkgs.millennium-steam.override {
          extraEnv = {
            MANGOHUD = "1";
          };

          extraPkgs =
            pkgs': with pkgs'; [
              keyutils
              libxcursor
              libxi
              libxinerama
              libxscrnsaver
              libkrb5
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib
            ];
        };

        extraPackages = with pkgs; [
          gamescope-wsi
          # hidapi
          mangohud
          protonup-ng
          steam-run
        ];

        extraCompatPackages = with pkgs; [ proton-ge-bin ];

        gamescopeSession = {
          enable = true;
          args = [
            "-W"
            "2560"
            "-H"
            "1440"
            "-r"
            "144"
            "-f"
            "--adaptive-sync"
            "--force-grab-cursor"
            "--hdr-itm-enable" # Tone Mapping for SDR content on HDR display
            # "--rt" # Real-Time Scheduling
            "--steam"
          ];

          env = {
            # DXVK_HDR = "1"; # HDR support in DX11/DX12 games
            ENABLE_VKBASALT = "1";
            MANGOHUD = "1";
          };

          steamArgs = [
            "-pipewire-dmabuf"
            "-gamepadui"
          ];
        };

        # Firewall
        remotePlay.openFirewall = true;
        # dedicatedServer.openFirewall = true;
        # localNetworkGameTransfers.openFirewall = true;
      };
    };

    environment = {
      sessionVariables = {
        PROTON_USE_NTSYNC = "1";
        SDL_VIDEODRIVER = "wayland";
      };

      systemPackages = with pkgs; [
        # (bottles.override { removeWarningPopup = true; })
        freetype
        steamcmd
        # winetricks
      ];
    };

    services.udev = {
      # packages = [ pkgs.game-devices-udev-rules ];

      extraRules = ''
        # Xbox Series X|S Controller
        ATTRS{idVendor}=="045e", TAG+="uaccess"

        # Nintendo Switch Pro Controller
        ATTRS{idVendor}=="057e", ATTRS{idProduct}=="2009", TAG+="uaccess"

        # Steam Controller / Virtual Gamepads
        KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"

        # USB Devices
        SUBSYSTEMS=="usb", TAG+="uaccess"

        # HID Devices over hidraw (Gyro)
        KERNEL=="hidraw*", TAG+="uaccess"
      '';
    };
  };
}
