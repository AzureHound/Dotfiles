{
  lib,
  self,
  config,
  osConfig,
  mkCfgLink,
  ...
}:

let
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.generators) toLua;
  inherit (lib.modules) mkIf;

  inherit (config.pixel.programs) defaults;
  inherit (osConfig.pixel.device) monitors keyboard;

  monitorList = mapAttrsToList (output: mon: {
    inherit output;
    inherit (mon) position scale;
    mode = "${mon.res}@${toString mon.hz}";
  }) monitors;
in

{
  options.programs.hyprland.enable = lib.options.mkEnableOption "Enable Hyprland";

  imports = [
    ./hypr-qt-support.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprshot.nix
    # ./hyprsunset.nix

    ./plugins.nix
  ];

  config = mkIf config.programs.hyprland.enable {

    wayland.windowManager.hyprland = {
      enable = true;

      package = null;
      portalPackage = null;

      systemd = {
        enable = true;
        variables = [ "--all" ];
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };

      configType = "lua";
      extraConfig = ''
        -- local kb = "${keyboard}"
        -- local editor = "${defaults.editor}"
        -- local terminal = "${defaults.terminal}"
        -- local screenLocker = "${defaults.screenLocker}"

        monitors = ${toLua { } monitorList}

        ${builtins.readFile (self + "/config/configHome/hypr/hyprland.lua")}
      '';
    };

    xdg.configFile = mkCfgLink (
      map (x: "hypr/${x}") [
        "scripts"
        "xdph.conf"
      ]
    );

    # Theme
    catppuccin.hyprland.enable = false;
  };
}
