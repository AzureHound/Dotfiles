{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.attrsets) genAttrs;
  inherit (lib.modules) mkIf mkMerge;

  appsDir = "${self}/config/home/.local/share/applications";
  cfg = "${config.home.homeDirectory}/Developer/dotfiles";
in

{
  imports = [
    ./Home.nix
    ./configHome.nix
    ./scripts.nix
  ];

  options = {
    home = {
      bin = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = { };
      };

      scripts = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = { };
      };
    };

    ign.desktop = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = mkMerge [
    {
      _module.args = {
        mkHomeLink =
          files:
          genAttrs files (f: {
            source = config.lib.file.mkOutOfStoreSymlink "${cfg}/config/home/${f}";
          });

        mkCfgLink =
          files:
          genAttrs files (f: {
            source = config.lib.file.mkOutOfStoreSymlink "${cfg}/config/configHome/${f}";
          });

        mkBinLink =
          ignored:
          builtins.listToAttrs (
            map
              (name: {
                name = ".local/bin/${name}";
                value = {
                  source = config.lib.file.mkOutOfStoreSymlink "${cfg}/config/home/.local/bin/${name}";
                };
              })
              (
                builtins.filter (n: !(builtins.elem n ignored)) (builtins.attrNames (builtins.readDir "${self}/config/home/.local/bin"))
              )
          );

        mkScptLink =
          files:
          builtins.listToAttrs (
            map (f: {
              name = ".local/bin/${f}";
              value = {
                source = config.lib.file.mkOutOfStoreSymlink "${cfg}/config/home/.local/scripts/${f}";
              };
            }) files
          );

        mkIgLink =
          ignored:
          builtins.listToAttrs (
            map (name: {
              name = "applications/${name}";
              value = {
                source = "${appsDir}/${name}";
              };
            }) (builtins.filter (n: !(builtins.elem n ignored)) (builtins.attrNames (builtins.readDir appsDir)))
          );
      };

      home = {
        activation = {
          mkDeveloper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            mkdir -p ${config.home.homeDirectory}/Developer
          '';

          mkDirectories = mkIf config.pixel.profiles.graphical.enable (
            lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              mkdir -p ${config.home.homeDirectory}/Archive \
                "${config.home.homeDirectory}/.local/bin" \
                "${config.xdg.dataHome}/Lyrics"
            ''
          );
        };

        file =
          with config.home;
          mkMerge [
            bin
            scripts
          ];
      };
    }
  ];
}
