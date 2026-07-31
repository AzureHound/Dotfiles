{ config, ... }:

{
  services.mullvad-vpn = {
    inherit (config.pixel.profiles.graphical) enable;

    enableExcludeWrapper = false;

    gui.enable = true;
  };
}
