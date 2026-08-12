{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.profiles.development;
in

{
  options.pixel.profiles.development.enable = mkEnableOption "Development profile";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # android-tools
      # atac
      # bun
      # cargo
      # claude-code
      # clickgen
      # deno
      dig
      # gemini-cli
      # gh-copilot
      go
      # hugo
      # lazysql
      # mkcert
      onefetch
      # pnpm
      # poetry
      # postgresql
      # scc
      # sqlite
      # tldx
      # usage
      # uv
      # virtualenv
      whois
      # yarn
    ];
  };
}
