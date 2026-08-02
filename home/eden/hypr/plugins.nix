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
    rev = "v0.55.4";
    hash = "sha256-sERoTu9NcGD0RA3jAdHc4GOPkRbgqMrgDT8f7+Jv9fc=";
  }) { };
in

{
  config = mkIf config.programs.hyprland.enable {
    wayland.windowManager.hyprland = {
      plugins = [
        hyprexpo
        pkgs.hyprlandPlugins.csgo-vulkan-fix
      ];
    };
  };
}
