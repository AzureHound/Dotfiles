{ lib, config, ... }:

let
  inherit (lib.attrsets) genAttrs;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib) types;

  cfg = config.pixel.services.arr;
in

{
  options.pixel.services.arr = {
    enable = mkEnableOption "arr services";

    mediaDir = mkOption {
      type = types.str;
      default = "/media";
    };

    contentDir = mkOption {
      type = types.str;
      default = "${cfg.mediaDir}/content";
      defaultText = "\${cfg.mediaDir}/content";
    };

    mediaOwner = mkOption {
      type = types.str;
      default = "root";
    };

    mediaGroup = mkOption {
      type = types.str;
      default = "media";
    };

    openFirewall = mkEnableOption "open the firewall for the arr services" // {
      default = true;
      defaultText = "true";
    };
  };

  config = mkIf cfg.enable {
    pixel.services = {
      jellyfin.enable = true;
      # prowlarr.enable = true;
      qbittorrent.enable = true;
      # radarr.enable = false;
      # sonarr.enable = true;
    };

    users.groups.media = { };

    systemd.tmpfiles.settings."media" =
      genAttrs
        [
          "${cfg.mediaDir}"
          "${cfg.mediaDir}/content"
          "${cfg.mediaDir}/content/home"
          "${cfg.mediaDir}/content/movies"
          "${cfg.mediaDir}/content/shows"

          "${cfg.mediaDir}/downloads"
          "${cfg.mediaDir}/downloads/movies"
          "${cfg.mediaDir}/downloads/shows"
        ]
        (_: {
          d = {
            mode = "0775";
            user = cfg.mediaOwner;
            group = cfg.mediaGroup;
          };
        });
  };
}
