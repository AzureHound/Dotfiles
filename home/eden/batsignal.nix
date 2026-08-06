{ pkgs, config, ... }:

{
  services.batsignal = {
    enable = config.pixel.profiles.laptop.enable && pkgs.stdenv.hostPlatform.isLinux;

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
