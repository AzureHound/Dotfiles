{
  lib,
  self,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  options.programs.sway.enable = lib.mkEnableOption "Enable Sway";

  imports = [ ];

  config = mkIf config.programs.sway.enable {
    wayland.windowManager.sway = {
      enable = true;

      package = null;

      config = lib.mkForce null;
      extraConfig = builtins.readFile (self + "/config/configHome/sway/config");
    };

    xdg.configFile = mkCfgLink (
      map (x: "sway/${x}") [
        "configs"
        "scripts"
        "theme"
      ]
    );

    # Theme
    catppuccin.sway.enable = false;
  };
}
