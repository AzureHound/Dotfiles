{ config, ... }:

{
  services.autotiling.enable = config.programs.sway.enable;
}
