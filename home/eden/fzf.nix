{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.profiles.workstation.enable {
    programs.fzf = {
      enable = true;

      colors = {
        fg = "#cad3f5";
        "fg+" = "#cad3f5";
        bg = "-1";
        "bg+" = "-1";
        gutter = "#24273a";
        header = "#ed8796";
        hl = "#eed49f";
        "hl+" = "#a6da95";
        query = "#a6da95";
        border = "#494d64";
        separator = "#b7bdf8";
        scrollbar = "#f0c6c6";
        marker = "#f4dbd6";
        pointer = "#a6da95";
        "selected-bg" = "#494d64";
        prompt = "#c6a0f6";
        info = "#f4dbd6";
        spinner = "#f4dbd6";
      };

      historyWidget.command = "";

      defaultCommand = "${getExe pkgs.fd} --type=f --hidden --exclude=.git";
      defaultOptions = [
        "--bind 'ctrl-u:preview-half-page-up'"
        "--bind 'ctrl-d:preview-half-page-down'"
        "--bind 'ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)'"
        "--bind 'alt-j:down+down+down+down+down'"
        "--bind 'alt-k:up+up+up+up+up'"
        "--bind 'alt-down:down+down+down+down+down'"
        "--bind 'alt-up:up+up+up+up+up'"
        "--multi"
        "--info=right"
        "--preview='fzf-preview {}'"
        "--tmux=center,100%"
        "--height=100%"
        "--padding=1"
        "--preview-window=right:70%"
        "--prompt '󰥨 Search: '"
        "--marker '✓ '"
        "--pointer='❯'"
        "--separator='─'"
        "--scrollbar='│'"
      ];
    };

    home.sessionVariables = {
      fzf_preview_dir_cmd = "eza --long --header --icons --all --color=always --group-directories-first --hyperlink=auto";
      fzf_fd_opts = "--hidden --color=always";
      _ZO_FZF_OPTS = "$FZF_DEFAULT_OPTS '--preview \"{$fzf_preview_dir_cmd} {2}\"'";
    };

    # Theme
    catppuccin.fzf.enable = false;
  };
}
