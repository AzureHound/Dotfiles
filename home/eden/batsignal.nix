{ pkgs, config, ... }:

{
  services.batsignal = {
    enable = pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.laptop.enable;

    extraArgs = [
      "-f"
      "60"
      "-w"
      "30"
      "-c"
      "20"
    ];
  };
}
