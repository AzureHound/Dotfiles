{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;

  inherit (config.pixel) device;
in

{
  config = mkIf (device.cpu == "amd") {
    hardware.cpu.amd.updateMicrocode = true;

    boot = {
      kernelModules = [
        "kvm-amd"
      ];

      kernelParams = [
        "amd_pstate=active"
      ];
    };
  };
}
