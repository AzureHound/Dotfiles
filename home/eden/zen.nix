{
  pkgs,
  name,
  config,
  inputs,
  osConfig,
  ...
}:

let
  extensions = inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system}.repos.rycee.firefox-addons;
in

{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    setAsDefaultBrowser = false;

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
    };

    profiles.${name} = {
      id = 0;
      inherit name;
      isDefault = true;

      extensions = {
        force = true;
        packages = with extensions; [
          bitwarden
          darkreader
          sponsorblock
          stylus
          ublock-origin
        ];
      };

      mods = [
        "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
        "c01d3e22-1cee-45c1-a25e-53c0f180eea8" # Ghost Tabs
        "c8d9e6e6-e702-4e15-8972-3596e57cf398" # Zen Back Forward
        "58649066-2b6f-4a5b-af6d-c3d21d16fc00" # Private Mode Highlighting
        # "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
        # "803c7895-b39b-458e-84f8-a521f4d7a064" # Hide Inactive Workspaces
        "599a1599-e6ab-4749-ab22-de533860de2c" # Pimp your PiP
      ];

      pinsForce = true;
      pinsForceAction = "remove";

      containersForce = true;
      containers = {
        "1" = {
          id = 1;
          name = "Personal";
          icon = "fingerprint";
          color = "blue";
        };
        "2" = {
          id = 2;
          name = "Code";
          icon = "tree";
          color = "turquoise";
        };
        "3" = {
          id = 3;
          name = "Social";
          icon = "chill";
          color = "yellow";
        };
        "4" = {
          id = 4;
          name = "Selfhost";
          icon = "fence";
          color = "blue";
        };
        "5" = {
          id = 5;
          name = "Len";
          icon = "fruit";
          color = "purple";
        };
      };

      # `cat /proc/sys/kernel/random/uuid`
      spacesForce = true;
      spaces = {
        "1" = {
          id = "b1d18fdb-7282-4fb7-8539-437ecca47616";
          name = "Personal";
          icon = "🧑‍💻";
          container = 1;
          theme = {
            type = "gradient";
            colors = [
              {
                red = 60;
                green = 85;
                blue = 115;
                algorithm = "floating";
                type = "explicit-lightness";
                lightness = 45;
              }
            ];
            opacity = 0.8;
            texture = 0.5;
          };
        };
        "2" = {
          id = "5f4690d4-7cc1-4623-8ea2-2934bcfde905";
          name = "Code";
          icon = "🐍";
          container = 2;
          theme = {
            type = "gradient";
            colors = [
              {
                red = 35;
                green = 115;
                blue = 65;
                algorithm = "floating";
                type = "explicit-lightness";
                lightness = 45;
              }
            ];
            opacity = 0.8;
            texture = 0.5;
          };
        };
        "3" = {
          id = "d0f16db3-fcfe-4d76-82f2-01e2ceda8b0d";
          name = "Social";
          icon = "⌛";
          container = 3;
          theme = {
            type = "gradient";
            colors = [
              {
                red = 220;
                green = 160;
                blue = 40;
                algorithm = "floating";
                type = "explicit-lightness";
                lightness = 50;
              }
            ];
            opacity = 0.8;
            texture = 0.5;
          };
        };
        "4" = {
          id = "b6558ed9-db04-4e7a-bdeb-1983f1e1b8a4";
          name = "Selfhost";
          icon = "🧩";
          container = 4;
          theme = {
            type = "gradient";
            colors = [
              {
                red = 40;
                green = 100;
                blue = 200;
                algorithm = "floating";
                type = "explicit-lightness";
                lightness = 50;
              }
            ];
            opacity = 0.8;
            texture = 0.5;
          };
        };
      };

      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";

        order = [
          "ddg"
          "google"
        ];

        engines = {
          "google".metaData.alias = "@g";

          "bing".metaData.hidden = true;
          "perplexity".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };
      };

      settings = {
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.display.document_color_use" = 0;
        "browser.display.use_document_fonts" = 0;
        "browser.download.autohideButton" = true;
        "browser.framerate.idle" = true;
        "browser.search.suggest.enabled" = true;
        "browser.tabs.inTitlebar" = if pkgs.stdenv.hostPlatform.isLinux then 0 else 1;
        "browser.tabs.unloadOnLowMemory" = true;
        "browser.tabs.warnOnClose" = true;
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            widget-overflow-fixed-list = [ ];
            unified-extensions-area = [
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" # bitwarden
              "ublock0_raymondhill_net-browser-action"
              "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action" # stylus
              "addon_darkreader_org-browser-action"
              "sponsorblocker_ajay_app-browser-action"
            ];
            nav-bar = [
              "home-button"
              "back-button"
              "forward-button"
              "customizableui-special-spring1"
              "vertical-spacer"
              "urlbar-container"
              "customizableui-special-spring2"
              "unified-extensions-button"
            ];
            toolbar-menubar = [ "menubar-items" ];
            TabsToolbar = [ "tabbrowser-tabs" ];
            vertical-tabs = [ ];
            PersonalToolbar = [
              "import-button"
              "personal-bookmarks"
            ];
            zen-sidebar-top-buttons = [ ];
            zen-sidebar-foot-buttons = [
              "downloads-button"
              "zen-workspaces-button"
              "zen-create-new-button"
            ];
          };
          seen = [
            "developer-button"
            "screenshot-button"
            "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" # bitwarden
            "ublock0_raymondhill_net-browser-action"
            "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action" # stylus
            "addon_darkreader_org-browser-action"
            "sponsorblocker_ajay_app-browser-action"
          ];
          dirtyAreaCache = [
            "nav-bar"
            "vertical-tabs"
            "zen-sidebar-foot-buttons"
            "PersonalToolbar"
            "toolbar-menubar"
            "TabsToolbar"
            "zen-sidebar-top-buttons"
            "unified-extensions-area"
          ];
          currentVersion = 23;
          newElementCount = 4;
        };
        "browser.urlbar.suggest.clipboard" = false;
        "font.name.monospace.x-western" = "JetBrainsMono Nerd Font";
        "font.name.sans-serif.x-western" = "Josefin Sans";
        "font.name.serif.x-western" = "Josefin Sans";
        "full-screen-api.warning.timeout" = 0;
        "gfx.webrender.all" = true;
        "identity.fxaccounts.account.device.name" = "${osConfig.networking.hostName}";
        "intl.regional_prefs.use_os_locales" = true;
        "layers.acceleration.force-enabled" = true;
        "media.ffmpeg.vaapi.enabled" = pkgs.stdenv.hostPlatform.isLinux;
        "media.ffvpx.enabled" = false;
        "media.rdd-vpx.enabled" = false;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = true;
        "network.trr.mode" = if config.pixel.profiles.laptop.enable then 2 else 5;
        "privacy.userContext.newTabContainerOnLeftClick.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "zen.glance.activation-method" = "shift";
        "zen.tabs.ctrl-tab.ignore-pending-tabs" = true;
        "zen.tabs.vertical.right-side" = true;
        "zen.view.compact.enable-at-startup" = true;
        "zen.view.compact.hide-toolbar" = true;
        "zen.view.show-newtab-button-top" = false;
        "zen.view.use-single-toolbar" = false;
        "zen.welcome-screen.seen" = true;
        "zen.workspaces.continue-where-left-off" = true;
        "zen.workspaces.force-container-workspace" = true;
      };

      keyboardShortcuts = [
        {
          id = "zen-workspace-switch-1";
          key = "1";
          modifiers.control = true;
        }
        {
          id = "zen-workspace-switch-2";
          key = "2";
          modifiers.control = true;
        }
        {
          id = "zen-workspace-switch-3";
          key = "3";
          modifiers.control = true;
        }
        {
          id = "zen-workspace-switch-4";
          key = "4";
          modifiers.control = true;
        }
      ];
      keyboardShortcutsVersion = 20;
    };
  };
}
