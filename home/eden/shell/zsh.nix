{ pkgs, config, ... }:

{
  programs.zsh = {
    dotDir = "${config.xdg.configHome}/zsh";

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    autocd = true;

    zsh-abbr = {
      enable = true;
      globalAbbreviations = {
        Aio = "sudo liquidctl --match 'NZXT Kraken X' set pump speed 20";
        gamedir = "cd /mnt/games/SteamLibrary/steamapps/common";
        HyperX = "mechsim -V 100 -s cherrymx-black-pbt";
      };
    };

    history = {
      append = true;
      size = 100000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignorePatterns = [
        "cp *"
        "pkill *"
        "rm *"
      ];
      ignoreAllDups = true;
      saveNoDups = true;
      findNoDups = true;
      expireDuplicatesFirst = true;
    };

    initContent = ''
      setopt auto_param_slash
      setopt auto_menu
      setopt menu_complete
      setopt correct
      setopt interactive_comments
      setopt extended_glob
      setopt globdots
      setopt inc_append_history
      setopt hist_reduce_blanks
      setopt hist_verify
      setopt no_case_glob
      setopt no_case_match
      setopt notify
      setopt numeric_glob_sort

      unsetopt prompt_sp

      export PINENTRY_USER_DATA=curses
      export GPG_TTY=$(tty)
      gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

      ZVM_INIT_MODE=sourcing
      ABBR_GET_AVAILABLE_ABBREVIATION=1
      ABBR_LOG_AVAILABLE_ABBREVIATION=1
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

      ZVM_VI_EDITOR=vim
      ZVM_SYSTEM_CLIPBOARD_ENABLED=true
      ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
      ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
      ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
      ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE
      # ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE

      ZVM_VI_HIGHLIGHT_FOREGROUND=#A6DA95
      ZVM_VI_HIGHLIGHT_BACKGROUND=#ED8796
      ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold,underline

      function .() {
        local input="$1"
        if [[ "$input" =~ ^[1-9][0-9]*$ ]]; then
          for ((i = 0; i < input; i++)); do
            cd ..
          done
        elif [[ -f "$input" ]]; then
          builtin . "$@"
        else
          echo "Invalid input format. Please use '<number>' to go back a specific number of directories."
        fi
      }

      function bj() {
        nohup "$@" </dev/null &>/dev/null &
      }

      function img() {
        if [ "$TERM" = "xterm-kitty" ] || [ -n "$KITTY_WINDOW_ID" ]; then
          kitten icat "$@"
        elif [ "$TERM" = "foot" ] || [ "$TERM" = "xterm-256color" ] || [ -n "$FOOT_SERVER" ]; then
          chafa --format=sixels "$@"
        else
          if command -v img2sixel >/dev/null 2>&1; then
            img2sixel "$@"
          elif command -v kitten >/dev/null 2>&1; then
            kitten icat "$@"
          else
            echo "No image viewer available"
          fi
        fi
      }

      zshaddhistory() {
        local cmd=(''${(z)1}) j=1
        while [[ ''${cmd[$j]} == *=* ]]; do ((j++)); done
        whence ''${cmd[$j]} >| /dev/null || return 1
      }

      chpwd() {
        eza -a
      }

      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' menu no
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      # zstyle ':completion:*' verbose true

      # zstyle ':completion:*:paths' accept-exact '*(N)'
      zstyle ':completion:*:functions' ignored-patterns '_*'
      zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

      zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/zcompcache"
      zstyle ':completion:*' use-cache on

      zstyle ':fzf-tab:*' fzf-flags \
        '--tmux=center,100%' '--height=100%' '--padding=1' '--preview-window=right:70%' \
        '--prompt=󰥨 Search: ' '--marker=✓ ' '--pointer=❯' '--separator=─' '--scrollbar=│' \
        '--color=fg:#cad3f5,fg+:#cad3f5,bg:-1,bg+:-1,gutter:#24273a' \
        '--color=header:#ed8796,hl:#eed49f,hl+:#a6da95,query:#a6da95' \
        '--color=border:#494d64,separator:#b7bdf8,scrollbar:#f0c6c6' \
        '--color=marker:#f4dbd6,pointer:#a6da95,selected-bg:#494d64' \
        '--color=prompt:#c6a0f6,info:#f4dbd6,spinner:#f4dbd6'

      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -a -1 --show-symlinks --git-ignore --color=always $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -a -1 --show-symlinks --git-ignore --color=always $realpath'
      zstyle ':fzf-tab:*' use-fzf-default-opts no
      zstyle ':fzf-tab:*' switch-group '<' '>'

      bindkey '^p'  history-search-backward
      bindkey '^n'  history-search-forward
      bindkey '^[w' kill-region
      bindkey '^Z'  undo
      # bindkey ' '   magic-space

      bindkey -s '^Xgs' 'git status\n'
      # bindkey -s '^Xgp' 'git push origin '
      bindkey -s '^Xgc' 'git commit -m ""\C-b'
      bindkey -s '^Xgl' 'git log --oneline -n 10\n'

      zle -N edit-command-line # vv
      zle_highlight+=(paste:none)

      alias -s html=open
      alias -s json=jless
      alias -s log=bat
      alias -s md=glow
      alias -s mov=open
      alias -s mp4=open
      alias -s png=open
      alias -s py='$EDITOR'
      alias -s txt=bat
      alias -s yaml='bat -l yaml'
      alias -s yml='bat -l yaml'
    '';

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "sudo";
        src = "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/sudo";
      }
      {
        name = "zsh-safe-rm";
        src = pkgs.stdenv.mkDerivation {
          name = "zsh-safe-rm";
          src = pkgs.fetchFromGitHub {
            owner = "mattmc3";
            repo = "zsh-safe-rm";
            rev = "6ab18fd";
            fetchSubmodules = true;
            hash = "sha256-1W8TdtcuksELl9L/lnKFPWdw27TBgYJBfNcrBivJuqI=";
          };
          installPhase = ''
            mkdir -p $out
            cp -R * $out/
            sed -i 's|/bin/bash|/usr/bin/env bash|' $out/shell-safe-rm/bin/rm.sh
          '';
        };
      }
      {
        name = "zsh-vi-mode";
        src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
      }
    ];
  };
}
