{
  lib,
  name,
  config,
  osClass,
  hostname,
  ...
}:

let
  home = "${if osClass == "nixos" then "/home" else "/Users"}/${name}";
in

{
  sops.secrets."syncthing" = { };

  services.syncthing = {
    guiAddress = "127.0.0.1:8384";

    guiCredentials = {
      username = name;
      passwordFile = config.sops.secrets."syncthing".path;
    };

    settings = {
      devices = {
        "Legion" = {
          id = "J2DKG2E-EZRXZFZ-X75VFH7-GNPFODV-LA3UC34-4NZWDPY-Q4CD4UC-AYAKWAZ";
        };
        "Newton" = {
          id = "WXWHPPC-FO5QWAY-JDMUIEY-QCMA3PT-KX6N7RW-ANOZWXR-3OWQ3WV-DV7KSQ4";
        };
        "Notebook" = {
          id = "M7HWYVS-EFX4JQS-M7L6O7G-WMOUMCX-C6E2MNB-ZXGBEVN-GXMPEWZ-K37U6AY";
        };
        "Orion" = {
          id = "KX7A2YG-V5JKB2X-J3FTPOD-K4HAFMS-MYJUZDD-VS7DIMU-HR3AWQI-CA63RQN";
        };
      };

      folders = lib.filterAttrs (_: v: builtins.elem hostname v.devices) {
        "Music" = {
          id = "music";
          path = "${home}/Music";
          devices = [
            "Legion"
            "Notebook"
            "Orion"
          ];
          ignorePerms = false;
          ignorePatterns = [ "(?d).DS_Store" ];
          maxConflicts = 0;
        };

        "Obsidian" = {
          id = "obsidian";
          path = "${home}/Obsidian";
          devices = [
            "Legion"
            "Newton"
            "Notebook"
            "Orion"
          ];
          ignorePerms = false;
          ignorePatterns = [ "(?d).DS_Store" ];
          maxConflicts = 0;
        };

        "Sync" = {
          id = "sync";
          path = "${home}/Sync";
          devices = [
            "Legion"
            "Newton"
            "Notebook"
            "Orion"
          ];
          ignorePerms = false;
          ignorePatterns = [ "(?d).DS_Store" ];
          maxConflicts = 0;
        };

        "Wallpapers" = {
          id = "wallpapers";
          path = "${home}/Videos/Wallpapers";
          devices = [
            "Legion"
            "Orion"
          ];
          ignorePerms = false;
          ignorePatterns = [ "(?d).DS_Store" ];
          maxConflicts = 0;
        };
      };

      options.urAccepted = -1;
    };
  };
}
