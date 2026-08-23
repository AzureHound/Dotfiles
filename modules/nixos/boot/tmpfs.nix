{ lib, config, ... }:

let
  inherit (lib.modules) mkDefault;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.system.boot;
in

{
  options.pixel.system.boot = {
    tmpOnTmpfs = mkEnableOption "`/tmp` living on tmpfs" // {
      default = true;
    };
  };

  config.boot.tmp = {
    useTmpfs = cfg.tmpOnTmpfs;
    cleanOnBoot = mkDefault (!config.boot.tmp.useTmpfs);
    # tmpfsSize = mkDefault "75%";
    tmpfsHugeMemoryPages = "within_size";
  };
}
