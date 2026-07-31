{
  lib,
  _class,
  config,
  ...
}:

let
  inherit (lib.attrsets) genAttrs;
  inherit (lib.modules) mkDefault;
in

{
  users.users = genAttrs config.pixel.system.users (
    name:
    let
      inherit (config.home-manager.users.${name}.pixel.programs.defaults) shell;
    in
    {
      shell = "/run/current-system/sw/bin/${shell}";
    }
    // (
      if _class == "nixos" then
        {
          home = "/home/${name}";

          uid = mkDefault 1000;
          isNormalUser = true;

          extraGroups = [
            "adbusers"
            "audio"
            "bluetooth"
            "cloudflared"
            "dialout"
            "disk"
            "docker"
            "gamemode"
            "git"
            "i2c"
            "incus-admin"
            "input"
            "libvirtd"
            "lp"
            "lpadmin"
            "media"
            "mysql"
            "network"
            "networkmanager"
            "nix"
            "pipewire"
            "power"
            "render"
            "scanner"
            "seat"
            "systemd-journal"
            "tty"
            "tss"
            "uinput"
            "video"
            "wheel"
            "wireshark"
          ];
        }
      else
        { home = "/Users/${name}"; }
    )
  );
}
