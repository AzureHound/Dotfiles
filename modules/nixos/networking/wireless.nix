{
  hardware.wirelessRegulatoryDatabase = true;

  networking.wireless = {
    # wpa_supplicant
    userControlled.enable = true;
    allowAuxiliaryImperativeNetworks = true;
    extraConfig = ''
      update_config=1
    '';

    # iwd
    iwd.settings = {
      # Settings.AutoConnect = true;

      General = {
        # AddressRandomization = "network";
        # AddressRandomizationRange = "full";

        # EnableNetworkConfiguration = true;
        RoamRetryInterval = 15;
      };
    };
  };
}
