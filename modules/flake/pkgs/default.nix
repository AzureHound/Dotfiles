{ pkgs, inputs, ... }:

removeAttrs (pkgs.lib.customisation.makeScope pkgs.newScope (self: {
  inherit inputs;

  update-pins = self.callPackage ./update-pins/pkg.nix { };
})) [ "inputs" ]
