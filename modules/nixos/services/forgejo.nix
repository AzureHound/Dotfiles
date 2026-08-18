{
  lib,
  self,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf mkForce;
  inherit (self.lib) mkServiceOption mkSecret;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.forgejo;
in

{
  options.pixel.services.forgejo = mkServiceOption "forgejo" {
    port = 3011;
    domain = "git.${rdomain}";
  };

  config = mkIf cfg.enable {
    sops.secrets = {
      forgejo-mail-id = mkSecret {
        file = "forgejo";
        key = "id";
        owner = "forgejo";
        group = "forgejo";
      };
      forgejo-mail-passwd = mkSecret {
        file = "forgejo";
        key = "passwd";
        owner = "forgejo";
        group = "forgejo";
      };
    };

    pixel.services = {
      redis.enable = true;
      postgresql.enable = true;
    };

    systemd.services.forgejo = {
      after = [ "postgresql.service" ];
      requires = [ "postgresql.service" ];
    };

    networking.firewall.allowedTCPPorts = [
      config.services.forgejo.settings.server.HTTP_PORT
      config.services.forgejo.settings.server.SSH_PORT
    ];

    services = {
      forgejo = {
        enable = true;
        package = pkgs.forgejo;
        lfs.enable = true;

        secrets.mailer = {
          USER = config.sops.secrets.forgejo-mail-id.path;
          PASSWD = config.sops.secrets.forgejo-mail-passwd.path;
        };

        settings = {
          federation.ENABLED = true;

          server = {
            PROTOCOL = "http";
            ROOT_URL = "https://${cfg.domain}";
            HTTP_PORT = cfg.port;
            DOMAIN = cfg.domain;

            START_SSH_SERVER = false;
            # BUILTIN_SSH_SERVER_USER = "git";
            DISABLE_ROUTER_LOG = true;
            # LANDING_PAGE = "/explore/repos";

            SSH_CREATE_AUTHORIZED_KEYS_FILE = true;
            SSH_PORT = lib.lists.head config.services.openssh.ports;

            OFFLINE_MODE = false;
          };

          api.ENABLE_SWAGGER = false;

          DEFAULT.APP_NAME = "Forgejo";
          attachment.ALLOWED_TYPES = "*/*";

          "ui.meta" = {
            AUTHOR = "Eden";
            DESCRIPTION = "Self-hosted Forgejo";
            KEYWORDS = "git,self-hosted,gitea,forgejo,azurehound,catppuccin,open-source,nix,nixos";
          };

          actions = {
            ENABLED = false;
            DEFAULT_ACTIONS_URL = "https://code.forgejo.org";
          };

          database = {
            DB_TYPE = mkForce "postgres";
            HOST = "/run/postgresql";
            NAME = "forgejo";
            USER = "forgejo";
            PASSWD = "forgejo";
          };

          cache = {
            ENABLED = true;
            ADAPTER = "redis";
            HOST = "redis://:forgejo@localhost:6371";
          };

          oauth2_client = {
            ACCOUNT_LINKING = "login";
            USERNAME = "nickname";
            ENABLE_AUTO_REGISTRATION = false;
            REGISTER_EMAIL_CONFIRM = false;
            UPDATE_AVATAR = true;
          };

          service = {
            DISABLE_REGISTRATION = true;
            ALLOW_ONLY_INTERNAL_REGISTRATION = true;
            EMAIL_DOMAIN_ALLOWLIST = "softshell.duckdns.org";
            ALLOW_ONLY_EXTERNAL_REGISTRATION = false;
          };

          session = {
            COOKIE_SECURE = true;
            SESSION_LIFE_TIME = 86400 * 7;
          };

          other = {
            SHOW_FOOTER_VERSION = false;
            SHOW_FOOTER_TEMPLATE_LOAD_TIME = false;
            ENABLE_FEED = false;
          };

          migrations.ALLOWED_DOMAINS = "github.com, *.github.com, gitlab.com, *.gitlab.com";
          packages.ENABLED = false;

          repository = {
            PREFERRED_LICENSES = "MIT,GPL-3.0,GPL-2.0,LGPL-3.0,LGPL-2.1";
            DISABLE_DOWNLOAD_SOURCE_ARCHIVES = true;
          };

          "repository.upload" = {
            FILE_MAX_SIZE = 100;
            MAX_FILES = 10;
          };

          mailer = {
            ENABLED = true;
            PROTOCOL = "smtps";
            SMTP_ADDR = "smtp.gmail.com:465";
          };
        };

        dump.enable = false;
      };

      openssh.settings.UsePAM = mkForce true;

      postgresql = {
        ensureDatabases = [ "forgejo" ];
        ensureUsers = lib.lists.singleton {
          name = "forgejo";
          ensureDBOwnership = true;
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://127.0.0.1:${toString cfg.port}";
    };

    # Theme
    catppuccin.forgejo = {
      enable = true;
      flavor = "macchiato";
      accent = "lavender";
    };
  };
}
