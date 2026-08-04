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
  programs.firefox = {
    policies = {
      AIControls = {
        Default = {
          Value = "blocked";
        };
      };
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
          blocktube
          darkreader
          multi-account-containers
          sponsorblock
          stylus
          surfingkeys
          ublock-origin
          violentmonkey
        ];
      };

      containersForce = true;
      containers = {
        "1" = {
          name = "Personal";
          id = 1;
          icon = "fingerprint";
          color = "blue";
        };
        "2" = {
          name = "Code";
          id = 2;
          icon = "tree";
          color = "turquoise";
        };
        "3" = {
          name = "Social";
          id = 3;
          icon = "chill";
          color = "yellow";
        };
        "4" = {
          name = "Selfhost";
          id = 4;
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

          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [
              "@np"
              "@nixpkgs"
            ];
          };

          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [
              "@no"
              "@nixopts"
            ];
          };

          "NixOS Wiki" = {
            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [
              "@nw"
              "@nixwiki"
            ];
          };

          "youtube" = {
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "https://www.youtube.com/favicon.ico";
            definedAliases = [ "@yt" ];
          };

          "bing".metaData.hidden = true;
          "perplexity".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };
      };

      settings = {
        "browser.aboutwelcome.didSeeFinalScreen" = true;
        "browser.aboutwelcome.enabled" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.display.use_document_fonts" = 0;
        "browser.download.alwaysOpenPanel" = false;
        # "browser.engagement.sidebar-button.has-used" = true;
        "browser.framerate.idle" = true;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.newtabWallpapers.user.enabled" = true;
        "browser.newtabpage.activity-stream.newtabWallpapers.wallpaper" = "firefox-a";
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        # "browser.startup.homepage" = "file:///home/${name}/Developer/Startpage/index.html";
        "browser.startup.page" = 3;
        "browser.tabs.inTitlebar" = 0;
        "browser.tabs.unloadOnLowMemory" = true;
        "browser.tabs.warnOnClose" = true;
        "browser.toolbarbuttons.introduced.sidebar-button" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.uiCustomization.navBarWhenVerticalTabs" = builtins.toJSON [
          "back-button"
          "forward-button"
          "stop-reload-button"
          "customizableui-special-spring1"
          "vertical-spacer"
          "urlbar-container"
          "customizableui-special-spring2"
          "downloads-button"
          "fxa-toolbar-menu-button"
          "unified-extensions-button"
          "alltabs-button"
          "sidebar-button"
        ];
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            widget-overflow-fixed-list = [ ];
            unified-extensions-area = [
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" # bitwarden
              "ublock0_raymondhill_net-browser-action"
              "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action" # stylus
              "addon_darkreader_org-browser-action"
              "sponsorblocker_ajay_app-browser-action"
              "_a8332c60-5b6d-41ee-bfc8-e9bb331d34ad_-browser-action" # surfingkeys
              "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action" # violentmonkey
            ];
            nav-bar = [
              "home-button"
              "back-button"
              "forward-button"
              "customizableui-special-spring1"
              "urlbar-container"
              "vertical-spacer"
              "customizableui-special-spring2"
              "_testpilot-containers-browser-action"
              "downloads-button"
              "unified-extensions-button"
              "alltabs-button"
              "sidebar-button"
            ];
            toolbar-menubar = [ "menubar-items" ];
            TabsToolbar = [ ];
            vertical-tabs = [ "tabbrowser-tabs" ];
            PersonalToolbar = [
              "import-button"
              "personal-bookmarks"
            ];
          };
          seen = [
            "developer-button"
            "screenshot-button"
            "_testpilot-containers-browser-action"
            "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" # bitwarden
            "ublock0_raymondhill_net-browser-action"
            "_6a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action" # stylus
            "addon_darkreader_org-browser-action"
            "sponsorblocker_ajay_app-browser-action"
            "_a8332c60-5b6d-41ee-bfc8-e9bb331d34ad_-browser-action" # surfingkeys
            "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action" # violentmonkey
            "reset-pbm-toolbar-button"
          ];
          dirtyAreaCache = [
            "nav-bar"
            "TabsToolbar"
            "vertical-tabs"
            "PersonalToolbar"
            "unified-extensions-area"
            "toolbar-menubar"
          ];
          currentVersion = 24;
          newElementCount = 2;
        };
        "font.name.monospace.x-western" = "JetBrainsMono Nerd Font";
        "font.name.sans-serif.x-western" = "Josefin Sans";
        "font.name.serif.x-western" = "Josefin Sans";
        "full-screen-api.warning.timeout" = 0;
        "gfx.webrender.all" = true;
        "identity.fxaccounts.account.device.name" = "${osConfig.networking.hostName}";
        "intl.regional_prefs.use_os_locales" = true;
        "layers.acceleration.force-enabled" = true;
        "media.eme.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = pkgs.stdenv.hostPlatform.isLinux;
        "media.ffvpx.enabled" = false;
        "media.rdd-vpx.enabled" = false;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = true;
        "network.trr.mode" = if config.pixel.profiles.laptop.enable then 0 else 5;
        "nimbus.rollouts.enabled" = false;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.trackingprotection.allow_list.baseline.enabled" = true;
        "privacy.trackingprotection.allow_list.convenience.enabled" = true;
        "privacy.trackingprotection.allow_list.hasUserInteractedWithETPSettings" = true;
        "privacy.userContext.newTabContainerOnLeftClick.enabled" = true;
        "sidebar.backupState" = builtins.toJSON {
          command = "";
          launcherExpanded = false;
          launcherVisible = false;
          launcherWidth = 0;
          panelOpen = false;
        };
        "sidebar.main.tools" = "history,bookmarks,passwords";
        "sidebar.new-sidebar.has-used" = true;
        "sidebar.position_start" = false;
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        "sidebar.visibility" = "hide-sidebar";
        "widget.dmabuf.force-enabled" = true;
      };
    };
  };
}
