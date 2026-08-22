{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.lists) concatLists head;
  inherit (lib.strings) concatMapStrings enableFeature getVersion;
  inherit (lib.versions) splitVersion;

  features = en: features: "--${en}-features=" + (concatMapStrings (x: x + ",") features);

  extension =
    {
      id,
      version,
      hash,
    }:
    {
      inherit id version;
      crxPath = pkgs.fetchurl {
        name = "${id}.crx";
        url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${head (splitVersion (getVersion config.programs.chromium.package))}&x=id%3D${id}%26installsource%3Dondemand%26uc";
        inherit hash;
      };
    };
in

{
  programs.chromium = {
    extensions = map extension [
      # Bitwarden
      {
        id = "nngceckbapebfimnlniiiahkandclblb";
        version = "2026.8.0";
        hash = "sha256-0aWULZwjTQM4LamSeZMgVQZMquejLMmxV5QMhjFl1Z8=";
      }

      # uBlock Origin
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
        version = "1.73.0";
        hash = "sha256-am9BiDyrsTDQCNXazBGIKEkMJwE3ZbNRiSR+i+oXg5E=";
      }

      # Stylus
      {
        id = "clngdbkpkpeebahjckkjfobafhncgmne";
        version = "2.4.10";
        hash = "sha256-+A+9w8Fc7VJD3Azofjyhchmpd2QQhDPoKsfkD6C9cpM=";
      }

      # SponsorBlock
      {
        id = "mnjggcdmjocbbbhaepdhchncahnbgone";
        version = "6.1.6";
        hash = "sha256-VYf+K2qZRhAcoN3nxu/nanVcXuW21uY9/EjH9zbNtP8=";
      }

      # ff2mpv
      {
        id = "ephjcajbkgplkjmelpglennepbpmdpjg";
        version = "6.0.0";
        hash = "sha256-4VEwf3rqtobbOElIsYi1mIcIvFS3KXlpHYfs3d+AzGg=";
      }
    ];

    nativeMessagingHosts = [ pkgs.ff2mpv-rust ];

    package = pkgs.ungoogled-chromium.override {
      enableWideVine = true;

      # https://github.com/secureblue/hardened-chromium
      # https://github.com/secureblue/secureblue/blob/e500f078efc5748d5033a881bbbcdcd2de95a813/files/system/usr/etc/chromium/chromium.conf.md
      commandLineArgs = concatLists [
        # Aesthetics
        [
          "--gtk-version=4"
          "--vertical-tabs"
        ]

        # Performance
        [
          (enableFeature true "gpu-rasterization")
          (enableFeature true "oop-rasterization")
          (enableFeature true "zero-copy")

          # Share a process per site
          "--process-per-site"

          # Parallel downloading
          (enableFeature true "parallel-downloading")

          # vaapi info: https://chromium.googlesource.com/chromium/src/+/refs/heads/main/docs/gpu/vaapi.md
          "--ignore-gpu-blocklist"
          "--disable-gpu-driver-bug-workaround"
        ]

        # Wayland
        [ "--ozone-platform=wayland" ]

        # Etc
        [
          "--disk-cache=$XDG_RUNTIME_DIR/chromium-cache"

          "--no-first-run"
          "--disable-wake-on-wifi"
          "--disable-breakpad"

          # Stop asking to be the default browser
          "--no-default-browser-check"

          # HDR
          (enableFeature true "experimental-web-platform-features")

          # rm speechd
          (enableFeature false "speech-api")
          (enableFeature false "speech-synthesis-api")

          # WebBluetooth
          "--enable-web-bluetooth"
        ]

        # Security
        [
          # Disable pings
          "--no-pings"

          # Require HTTPS for component updater
          "--component-updater=require_encryption"

          # Disable crash upload
          "--no-crash-upload"

          # Don't run things without asking
          "--no-service-autorun"

          # Disable sync
          "--disable-sync"

          # Disable canvas reading for privacy
          # (enableFeature false "reading-from-canvas")

          "--password-store=gnome-libsecret"
        ]

        [
          (features "enable" [
            # Wayland
            "UseOzonePlatform"

            "MiddleClickAutoscroll"

            # Allow manifest v2
            "AllowLegacyMV2Extensions"

            # See the performance section as to why these are added
            "AcceleratedVideoEncoder"
            "AcceleratedVideoDecodeLinuxGL"
            "VaapiOnNvidiaGPUs"
            "WaylandLinuxDrmSyncobj"

            # Enable visited link database partitioning
            "PartitionVisitedLinkDatabase"

            # Enable prefetch privacy changes
            "PrefetchPrivacyChanges"

            # Enable split cache
            "SplitCacheByNetworkIsolationKey"
            "SplitCodeCacheByNetworkIsolationKey"

            # Enable partitioning connections
            "EnableCrossSiteFlagNetworkIsolationKey"
            "HttpCacheKeyingExperimentControlGroup"
            "PartitionConnectionsByNetworkIsolationKey"

            # Enable strict origin isolation
            "StrictOriginIsolation"

            # Enable reduce accept language header
            "ReduceAcceptLanguage"

            # Enable content settings partitioning
            "ContentSettingsPartitioning"

            # Enable WebBluetooth
            "WebBluetooth"
          ])

          (features "disable" [
            # Disable autofill
            "AutofillPaymentCardBenefits"
            "AutofillPaymentCvcStorage"
            "AutofillPaymentCardBenefits"

            # Disable third-party cookie deprecation bypasses
            "TpcdHeuristicsGrants"
            "TpcdMetadataGrants"

            # Disable hyperlink auditing
            "EnableHyperlinkAuditing"

            # Disable showing popular sites
            "NTPPopularSitesBakedInContent"
            "UsePopularSitesSuggestions"

            # Disable article suggestions
            "EnableSnippets"
            "ArticlesListVisible"
            "EnableSnippetsByDse"

            # Disable content feed suggestions
            "InterestFeedV2"

            # Disable media DRM preprovisioning
            "MediaDrmPreprovisioning"

            # Disable autofill server communication
            "AutofillServerCommunication"

            # Disable new privacy sandbox features
            "PrivacySandboxSettings4"
            "BrowsingTopics"
            "BrowsingTopicsDocumentAPI"
            "BrowsingTopicsParameters"

            # Disable translate button
            "AdaptiveButtonInTopToolbarTranslate"

            # Disable detailed language settings
            "DetailedLanguageSettings"

            # Disable fetching optimization guides
            "OptimizationHintsFetching"

            # Partition third-party storage
            "DisableThirdPartyStoragePartitioningDeprecationTrial2"

            # Disable media engagement
            "PreloadMediaEngagementData"
            "MediaEngagementBypassAutoplayPolicies"

            # Allow manifest v2
            "ExtensionsManifestV3Only"
            "ExtensionManifestV2Unsupported"
            "ExtensionManifestV2Disabled"
          ])
        ]
      ];
    };
  };
}
