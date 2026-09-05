{
  lib,
  pkgs,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in

{
  config = mkIf config.pixel.profiles.workstation.enable {
    programs.yazi = {
      enable = true;

      plugins = {
        inherit (pkgs.yaziPlugins)
          compress
          convert
          full-border
          git
          githead
          lazygit
          mediainfo
          mount
          office
          rsync
          smart-filter
          toggle-pane
          yatline
          yatline-githead
          ;

        gvfs = mkIf isLinux pkgs.yaziPlugins.gvfs;

        eza-preview = pkgs.fetchFromGitHub {
          owner = "ahkohd";
          repo = "eza-preview.yazi";
          rev = "main";
          hash = "sha256-8isGaJSVu7R76hKfGRszMdBOItYjVOKqvDpv9ccpBAs=";
        };

        fg = pkgs.fetchFromGitHub {
          owner = "DreamMaoMao";
          repo = "fg.yazi";
          rev = "master";
          hash = "sha256-fgv7iNqx/4EMIcRGmXYY7Y+9/O+nZKeZtsbi0NQPCbw=";
        };

        glow = pkgs.fetchFromGitHub {
          owner = "AzureHound";
          repo = "glow.yazi";
          rev = "main";
          hash = "sha256-i4SfBdKtjVJS04H75tC5P2LaMyxaSFy7D98oRpq1n0w=";
        };

        ouch = pkgs.fetchFromGitHub {
          owner = "ndtoan96";
          repo = "ouch.yazi";
          rev = "main";
          hash = "sha256-t1kUo4+YODeTG9d5Yq/vxElcmRHIebC5TRv+uDGG88c=";
        };

        searchjump = pkgs.fetchFromGitHub {
          owner = "DreamMaoMao";
          repo = "searchjump.yazi";
          rev = "master";
          hash = "sha256-Rt1NMP1qksYdfFIywXAG2NJHZFFp9qwqxaxw+tXQtx0=";
        };
      };
    };

    xdg = {
      configFile = mkCfgLink (
        map (f: "yazi/${f}") [
          "flavors"
          "init.lua"
          "keymap.toml"
          "theme.toml"
          "yazi.toml"
        ]
      );

      desktopEntries = mkIf isLinux {
        yazi = {
          name = "Yazi";
          noDisplay = true;
        };
      };
    };

    # Theme
    catppuccin.yazi.enable = false;
  };
}
