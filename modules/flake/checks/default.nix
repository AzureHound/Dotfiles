{ pkgs, inputs, ... }:

let
  inherit (pkgs) lib;

  scope = lib.customisation.makeScope pkgs.newScope (scopeSelf: {
    inherit (inputs) self;

    formatting = scopeSelf.callPackage ./formatting.nix { };

    selflib = scopeSelf.callPackage ./lib.nix { };
  });
in

lib.attrsets.filterAttrs (_: lib.isDerivation) scope
