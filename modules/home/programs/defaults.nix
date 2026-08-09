{ lib, osClass, ... }:

let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.options) mkOption;
  inherit (lib.types) str enum nullOr;

  mkDefault = name: args: mkOption ({ description = "default ${name} for the system"; } // args);
in

{
  options.pixel.programs.defaults = mapAttrs mkDefault {
    shell = {
      type = enum [
        "bash"
        "fish"
        "nushell"
        "zsh"
      ];
      default = if (osClass == "nixos") then "bash" else "zsh";
    };

    terminal = {
      type = enum [
        "foot"
        "ghostty"
        "kitty"
      ];
      default = if (osClass == "nixos") then "kitty" else "ghostty";
    };

    editor = {
      type = enum [
        "codium"
        "nvim"
      ];
      default = "nvim";
    };

    pager = {
      type = str;
      default = "less -FR";
    };

    manpager = {
      type = str;
      default = "vim -M +MANPAGER -";
    };

    screenLocker = {
      type = nullOr (enum [
        "hyprlock"
        "swaylock"
      ]);
      default = "hyprlock";
    };
  };
}
