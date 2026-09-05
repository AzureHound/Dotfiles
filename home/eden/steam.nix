{
  lib,
  pkgs,
  inputs,
  osConfig,
  ...
}:

let
  gaming = osConfig.pixel.profiles.gaming.enable or false;
in

{
  imports = lib.optionals gaming [ inputs.millennium.homeManagerModules.default ];

  config =
    if gaming then
      {
        programs.steam = {
          theme = pkgs.millenniumThemes.adwaita;
          millenniumConfig = {
            themes.conditions."adwaita-for-steam" = {
              "Color theme" = "catppuccin-macchiato";
              "Hide What's New shelf" = "yes";
            };
          };

          plugins = with pkgs.millenniumPlugins; [
            # browser-history
            # hltb
          ];
        };
      }
    else
      { };
}
