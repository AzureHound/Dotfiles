{
  lib,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  imports = [ inputs.jelly.homeManagerModules.default ];

  config = mkIf config.pixel.profiles.media.watching.enable {
    sops.secrets.jelly = { };

    programs.jelly = {
      enable = true;

      server = "http://10.10.0.5:8096";
      apiKeySopsSecret = "jelly";
    };
  };
}
