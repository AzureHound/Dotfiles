{ pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;

      permittedInsecurePackages = [ ];

      allowAliases = false;
      allowBroken = false;
      allowUnsupportedSystem = false;
      allowVariants = true;

      # showDerivationWarnings = [ "maintainerless" ];
    };
  };

  # assertions = [
  #   {
  #     assertion = pkgs.overlays == [ ];
  #     message = "nixpkgs overlays are not allowed in my config.";
  #   }
  # ];
}
