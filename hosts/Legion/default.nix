{
  pkgs,
  name,
  inputs,
  ...
}:

{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.bluetooth
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.page-size-16k
    inputs.nixos-raspberrypi.nixosModules.usb-gadget-ethernet

    ./disko.nix
    ./hardware.nix
  ];

  boot.loader.raspberry-pi.bootloader = "kernel";

  home-manager.users.${name} = import ./home.nix;

  pixel = {
    profiles = {
      headless.enable = true;
      server.enable = true;
    };

    services = {
      docker.enable = true;
      forgejo.enable = true;
      homepage.enable = true;
      immich.enable = true;
      karakeep.enable = true;
      microbin.enable = true;
      navidrome.enable = true;
      nginx.enable = true;
      opencloud.enable = true;
      radicale.enable = true;
      samba.enable = true;
      search.enable = true;
      syncthing.enable = true;
      technitium.enable = true;
      vaultwarden.enable = true;

      # db
      postgresql.enable = true;
      redis.enable = true;
    };

    system = {
      boot = {
        loader = "none";
        silent = true;
      };
      networking.tailscale = {
        enable = true;
        mode = "server";
      };
      bluetooth.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];
}
