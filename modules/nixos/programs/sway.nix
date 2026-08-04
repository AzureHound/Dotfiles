{
  lib,
  self,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) anyHome;

  cond = anyHome config (conf: conf.wayland.windowManager.sway.enable);
in

{
  config = mkIf cond {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;

      extraPackages = with pkgs; [
        swaylock
        swayidle
      ];
    };
  };
}
