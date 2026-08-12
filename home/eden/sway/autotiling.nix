{ config, ... }:

{
  services.autotiling = {
    inherit (config.programs.sway) enable;
  };
}
