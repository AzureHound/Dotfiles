{ pkgs, ... }:

{
  programs = {
    bash.enable = true;

    btop = {
      enable = true;

      settings = {
        vim_keys = true;
      };
    };

    vim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [ catppuccin-vim ];
      extraConfig = ''
        let g:mapleader = " "
        filetype plugin indent on
        syntax enable
        set listchars=tab:>\ ,trail:·,space:\ 
        set fillchars=foldopen:,foldclose:,fold:\ ,foldsep:\ ,diff:╱,eob:\ 
        colorscheme catppuccin_macchiato
      '';
    };
  };

  home = {
    packages = with pkgs; [
      gitMinimal
      tmux
      yazi
    ];

    shellAliases = {
      logout = "exit";
    };
  };
}
