{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.attrsets) genAttrs;
  inherit (lib.lists) elemAt;
  inherit (lib.lists) filter;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.strings) splitString;
  inherit (lib.trivial) flip pipe;
  inherit (lib.types) str listOf;

  getArch = flip pipe [
    (splitString "-")
    (flip elemAt 0)
  ];

  cfg = config.pixel.system.emulation;
in

{
  options.pixel.system.emulation = {
    enable = mkEnableOption ''
      Emulate additional arch via binfmt.
    '';

    systems = mkOption {
      type = listOf str;
      default = filter (system: system != pkgs.stdenv.hostPlatform.system) [
        "x86_64-linux"
        "aarch64-linux"
        "i686-linux"
      ];
    };
  };

  config = mkIf cfg.enable {
    nix.settings.extra-sandbox-paths = [
      "/run/binfmt"
      (toString pkgs.qemu)
    ];

    boot.binfmt = {
      emulatedSystems = cfg.systems;

      registrations = genAttrs cfg.systems (system: {
        interpreter = "${pkgs.qemu}/bin/qemu-${getArch system}";
      });
    };
  };
}
