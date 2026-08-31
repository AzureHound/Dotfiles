{
  pkgs,
  name,
  inputs,
  ...
}:

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
      gaming.enable = true;
    };

    device = {
      cpu = "amd";
      gpu = "nvidia";
      monitors = {
        "DP-1" = {
          res = "2560x1440";
          hz = 120;
          position = "0x0";
          scale = "1.33";
        };
      };
      capabilities = {
        bluetooth = true;
        tpm = true;
        # yubikey = true;
      };
      # webcam = true;
    };

    system = {
      boot = {
        loader = "systemd-boot";
        silent = true;
      };
      bluetooth.enable = true;
      containers.enable = true;
      security.binaries.enable = true;
      emulation.enable = true;
      virtualization = {
        enable = true;
        windows.enable = true;
      };
    };
  };

  boot.loader.systemd-boot.consoleMode = "max";

  programs = {
    hyprland.enable = true;
  };

  services = {
    displayManager.defaultSession = "hyprland";
    logind.settings.Login.HandlePowerKey = "poweroff";
    ollama.package = pkgs.ollama-cuda;
    udev.packages = with pkgs; [ openrgb ];
  };

  systemd = {
    services.ollama.serviceConfig = {
      DeviceAllow = [
        "/dev/nvidia0"
        "/dev/nvidiactl"
        "/dev/nvidia-uvm"
        "/dev/nvidia-modeset"
      ];
    };

    tmpfiles.settings."games" = {
      "/mnt/games".d = {
        mode = "0755";
        user = name;
        group = "users";
      };
    };
  };
}
