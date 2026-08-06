{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;

  inherit (config.pixel) device;
in

{
  config = mkIf (device.cpu == "intel") {
    hardware.cpu.intel.updateMicrocode = true;

    boot = {
      kernelModules = [ "kvm-intel" ];

      kernelParams = [
        "i915.fastboot=1"
        "i915.enable_dc=4"
        "i915.enable_fbc=1"
        "i915.enable_guc=3"
        "i915.enable_psr=1"
        "i915.disable_power_well=1"
        "intel_pstate=active"
      ];
    };
  };
}
