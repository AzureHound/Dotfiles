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
        "Newton" = {
          id = "WXWHPPC-FO5QWAY-JDMUIEY-QCMA3PT-KX6N7RW-ANOZWXR-3OWQ3WV-DV7KSQ4";
        };
        "Notebook" = {
          id = "QWDKFNR-4EYOSYD-YNOJIB5-R4TTEL3-HEBDWBP-5FBH5JW-UBX5O2M-3MSZ2AT";
        };
        "Orion" = {
          id = "KX7A2YG-V5JKB2X-J3FTPOD-K4HAFMS-MYJUZDD-VS7DIMU-HR3AWQI-CA63RQN";
        };
        "Server" = {
          id = "VM5JQBF-WVJHXAD-7EGVDNR-OPTUXI5-ZOJFHJX-ZCJIPON-WVPONFO-I3D37AE";
        };
      };

      folders = lib.filterAttrs (_: v: builtins.elem hostname v.devices) {
        "Music" = {
          id = "music";
          path = "${home}/Music";
          devices = [
            "Notebook"
            "Orion"
            "Server"
          ];
          ignorePerms = false;
          ignorePatterns = [ "(?d).DS_Store" ];
          maxConflicts = 0;
        };

        "Obsidian" = {
          id = "obsidian";
          path = "${home}/Obsidian";
          devices = [
            "Newton"
            "Notebook"
            "Orion"
            "Server"
          ];
          ignorePerms = false;
          ignorePatterns = [ "(?d).DS_Store" ];
          maxConflicts = 0;
        };

        "Sync" = {
          id = "sync";
          path = "${home}/Sync";
          devices = [
            "Newton"
            "Notebook"
            "Orion"
            "Server"
          ];
          ignorePerms = false;
          ignorePatterns = [ "(?d).DS_Store" ];
          maxConflicts = 0;
        };

        "Wallpapers" = {
          id = "wallpapers";
          path = "${home}/Videos/Wallpapers";
          devices = [
            "Orion"
            "Server"
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
