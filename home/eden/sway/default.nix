{
  lib,
  self,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.modules) mkIf;

  cursor = config.home.pointerCursor;
in

{
  options.programs.sway.enable = lib.mkEnableOption "Enable Sway";

  imports = [
    ./autotiling.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  config = mkIf config.programs.sway.enable {
    wayland.windowManager.sway = {
      enable = true;

      package = null;

      config = lib.mkForce null;

      extraConfig = ''
        seat * xcursor_theme ${cursor.name} ${toString cursor.size}

        ${builtins.readFile (self + "/config/configHome/sway/config")}
      '';
    };

    xdg.configFile = mkCfgLink (
      map (x: "sway/${x}") [
        "configs"
        "scripts"
        "theme"
      ]
    );
  };
}
