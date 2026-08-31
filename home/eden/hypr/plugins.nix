{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;

  hyprexpo = pkgs.callPackage (pkgs.fetchFromGitHub {
    owner = "sandwichfarm";
    repo = "hyprexpo";
    rev = "v0.56.1+3";
    hash = "sha256-lI52XGlHMAXhn8ztpRkzefFy5ZnTIsQgAlTEVYTXseA=";
  }) { };
in

{
  config = mkIf config.programs.hyprland.enable {
    wayland.windowManager.hyprland = {
      plugins = [
        hyprexpo
        # pkgs.hyprlandPlugins.csgo-vulkan-fix
      ];
    };
  };
}