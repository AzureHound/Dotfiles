{
  lib,
  self,
  name,
  config,
  _class,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkServiceOption mkSecret;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.syncthing;
  home = "${if _class == "nixos" then "/home" else "/Users"}/${name}";
in

{
  options.pixel.services.syncthing = mkServiceOption "syncthing" {
    port = 8384;
    domain = "sync.${rdomain}";
  };

  config = mkIf cfg.enable {
    sops.secrets.passwd = mkSecret {
      file = "syncthing";
      owner = name;
      group = "users";
    };

    services = {
      syncthing = {
        enable = true;

        user = name;
        group = "users";
        configDir = "${home}/.config/syncthing";
        dataDir = "${home}/.local/share/syncthing";
        openDefaultPorts = true;

        guiAddress = "127.0.0.1:${toString cfg.port}";
        guiPasswordFile = config.sops.secrets.passwd.path;

        settings = {
          gui = {
            useTLS = true;
            user = name;
            insecureSkipHostcheck = true;
          };

          devices = {
            "Legion" = {
              id = "J2DKG2E-EZRXZFZ-X75VFH7-GNPFODV-LA3UC34-4NZWDPY-Q4CD4UC-AYAKWAZ";
            };
            "Newton" = {
              id = "WXWHPPC-FO5QWAY-JDMUIEY-QCMA3PT-KX6N7RW-ANOZWXR-3OWQ3WV-DV7KSQ4";
            };
            "Notebook" = {
              id = "QWDKFNR-4EYOSYD-YNOJIB5-R4TTEL3-HEBDWBP-5FBH5JW-UBX5O2M-3MSZ2AT";
            };
            "Orion" = {
              id = "EOM5CBO-6DY537D-PAX5345-LGDRK6J-DKENSVW-4QHDBWG-ZGI2OAT-FZEJVA6";
            };
          };

          folders = {
            "Music" = {
              id = "music";
              path = "${home}/Music";
              devices = [
                "Legion"
                # "Newton"
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
                # "Newton"
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
                # "Newton"
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

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://127.0.0.1:${toString cfg.port}";
    };
  };
}
