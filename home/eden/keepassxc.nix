{ config, ... }:

{
  programs.keepassxc = {
    inherit (config.pixel.profiles.workstation) enable;

    settings = {
      Browser.Enabled = true;

      GUI = {
        AdvancedSettings = true;
        ApplicationTheme = "dark";
        CompactMode = true;
        HidePasswords = true;
      };

      SSHAgent.Enabled = true;
    };
  };
}
