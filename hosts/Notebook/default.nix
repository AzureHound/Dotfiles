{
  lib,
  pkgs,
  name,
  inputs,
  ...
}:

let
  inherit (lib.meta) getExe;
in

{
  imports = [
    inputs.disko.nixosModules.disko

    ./disko.nix
    ./hardware.nix
  ];

  home-manager.users.${name} = import ./home.nix;

  pixel = {
    profiles = {
      graphical.enable = true;
      workstation.enable = true;
      laptop.enable = true;
    };

    device = {
      cpu = "intel";
      gpu = "intel";
      capabilities = {
        bluetooth = true;
        tpm = true;
        # yubikey = true;
      };
      webcam = true;
    };

    system = {
      boot = {
        loader = "systemd-boot";
        silent = true;
      };
      bluetooth.enable = true;
      networking.tailscale.enable = true;
      printing.enable = true;
    };
  };

  boot = {
    loader.systemd-boot.consoleMode = "keep";

    kernelModules = [ "ideapad_laptop" ];

    kernelParams = [
      "acpi_idle"
      "mem_sleep_default=deep"
      "nvme_core.default_ps_max_latency_us=5500"
    ];
  };

  hardware.sane = {
    enable = false;
    extraBackends = with pkgs; [ sane-airscan ];
    disabledDefaultBackends = [ "escl" ];
  };

  networking = {
    # mtr.enable = true;
    nat.externalInterface = "wlan0";
  };

  services.displayManager = {
    defaultSession = "sway";
    # autoLogin.enable = true;
    # autoLogin.user = name;
  };

  xdg.portal = {
    enable = true;

    wlr = {
      enable = true;
      settings = {
        screencast = {
          max_fps = 60;
          chooser_type = "simple";
          chooser_cmd = "${getExe pkgs.slurp} -f %o -or";
        };
      };
    };
  };

  # security.pam.services = {
  #   login.fprintAuth = true;
  #   sudo.fprintAuth = true;
  #
  #   swaylock.fprintAuth = true;
  # };

  services.fprintd.enable = false;

  systemd.tmpfiles.settings."ideapad-conservation-mode" = {
    "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode".w = {
      argument = "1";
    };
  };
}
