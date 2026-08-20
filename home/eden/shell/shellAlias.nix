{ lib, ... }:

let
  inherit (lib.modules) mkDefault;
in

{
  home.shellAliases = {
    ani-cli = ''FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --preview-window=hidden" ani-cli'';
    cp = "cp -irv";
    dev = "~/Developer";
    df = "df -h";
    grep = "grep --color=auto";
    ip = "ip -c a";
    jctl = "journalctl -p 3 -xb";
    mkdir = "mkdir -pv";
    mv = "mv -iv";
    open = "xdg-open";
    ping = "ping -c 10";
    powertop = "sudo powertop";
    proc = "sysz";
    pubip = "curl -4 https://icanhazip.com";
    rm = "trash";
    todo = "nvim ~/Obsidian/To-do.md";

    domain = "tldx";
    market = "ticker --config ~/.config/ticker/ticker.yml";
  };
}
