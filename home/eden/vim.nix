{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  programs.vim = mkIf config.pixel.profiles.workstation.enable {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      catppuccin-vim
      fzf-vim
      vim-commentary
      vim-gitgutter
      vim-tmux-navigator
      vim-wayland-clipboard
    ];

    settings = {
      background = "dark";
      expandtab = true;
      hidden = true;
      ignorecase = true;
      mouse = "a";
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      smartcase = true;
      tabstop = 2;
    };

    extraConfig = ''
      if !has('gui_running') && &term =~ '\%(screen\|tmux\)'
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      endif

      set runtimepath^=${config.xdg.configHome}/vim
      set runtimepath+=${config.xdg.dataHome}/vim
      set runtimepath+=${config.xdg.configHome}/vim/after

      set packpath^=${config.xdg.dataHome}/vim,${config.xdg.configHome}/vim
      set packpath+=${config.xdg.configHome}/vim/after,${config.xdg.dataHome}/vim/after

      let &viminfofile = "${config.xdg.stateHome}/vim/viminfo"

      let g:netrw_home = "${config.xdg.dataHome}/vim"
      call mkdir("${config.xdg.dataHome}/vim/spell", 'p')

      set backupdir=${config.xdg.stateHome}/vim/backup//   | call mkdir(&backupdir, 'p')
      set directory=${config.xdg.stateHome}/vim/swap//     | call mkdir(&directory, 'p')
      set undodir=${config.xdg.stateHome}/vim/undo//       | call mkdir(&undodir,   'p')
      set viewdir=${config.xdg.stateHome}/vim/view//       | call mkdir(&viewdir,   'p')

      let g:mapleader = " "
      let g:maplocalleader = "\\"
      let g:netrw_liststyle = 3
      let g:wayland_clipboard_unnamedplus = 1
      let g:wayland_clipboard_no_plus_to_w = 1

      filetype plugin indent on
      syntax enable

      set title
      set confirm
      set path+=**
      set encoding=UTF-8
      set ttimeoutlen=10
      set updatetime=200
      set backspace=indent,eol,start

      set termguicolors
      set cursorline
      set cursorlineopt=both
      set nocursorcolumn
      set signcolumn=yes
      set noshowmode
      set showcmd
      set cmdheight=1
      set scrolloff=10
      set sidescrolloff=8
      set smoothscroll
      set pumheight=10
      " set noruler
      set list
      set listchars=tab:>\ ,trail:·,space:\ 
      set fillchars=foldopen:,foldclose:,fold:\ ,foldsep:\ ,diff:╱,eob:\ 

      set nobackup
      set noswapfile
      set nowritebackup
      set undofile
      set undodir=~/.local/state/vim/undo
      set undolevels=10000
      set wildignore+=*/node_modules/*
      set shortmess=atWFson

      set softtabstop=2
      set autoindent
      set breakindent
      set smartindent
      set nowrap
      set linebreak
      set virtualedit=block
      set formatoptions=jcroqlnt
      " set spell spelllang=en_us

      set hlsearch
      set incsearch
      set showmatch
      set grepprg=rg\ --vimgrep\ --smart-case\ --follow

      set splitkeep=screen
      set splitbelow
      set splitright

      let &t_SI = "\<Esc>[5 q"
      let &t_SR = "\<Esc>[3 q"
      let &t_EI = "\<Esc>[1 q"

      let &t_ti .= "\<Esc>[1 q"
      let &t_te .= "\<Esc>[0 q"

      augroup numtoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,CmdlineLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
        autocmd BufLeave,FocusLost,InsertEnter,CmdlineEnter,WinLeave * if &nu | set nornu | endif
      augroup END

      augroup resize_splits
        autocmd!
        autocmd VimResized * tabdo wincmd =
      augroup END

      augroup last_loc
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
      augroup END

      augroup auto_create_dir
        autocmd!
        autocmd BufWritePre * if !isdirectory(expand("<afile>:p:h")) | call mkdir(expand("<afile>:p:h"), "p") | endif
      augroup END

      augroup disable_next_line_comments
        autocmd!
        autocmd BufEnter * setlocal formatoptions-=cro
      augroup END

      function! HighlightYank()
        let [begin, end] = [getpos("'["), getpos("']")]
        let id = matchaddpos('IncSearch', [[begin[1], begin[2], end[2]-begin[2]+1]])
        call timer_start(150, {-> matchdelete(id)})
      endfunction

      augroup highlight_yank
        autocmd!
        autocmd TextYankPost * call HighlightYank()
      augroup END

      function! TogglePaste()
        if &paste
          set nopaste
          echo "Paste Mode: Off"
        else
          set paste
          echo "Paste Mode: On"
        endif
      endfunction

      function! CustomHighlights()
        highlight GitGutterAdd guifg=#A6D189
        highlight GitGutterChange guifg=#E5C890
        highlight GitGutterDelete guifg=#ED8796
        highlight GitGutterChangeDelete guifg=#C6A0F6

        highlight GitGutterAddLine guibg=#292C3C
        highlight GitGutterChangeLine guibg=#292C3C
        highlight GitGutterDeleteLine guibg=#292C3C
        highlight GitGutterChangeDeleteLine guibg=#292C3C

        highlight LineNr ctermfg=grey guifg=#494d64
        highlight CursorLineNr ctermfg=blue guifg=#8aadf4
      endfunction

      autocmd ColorScheme * call CustomHighlights()

      let mapleader = " "

      nnoremap <Leader>p :call TogglePaste()<CR>
      nnoremap <C-s> :w<CR>
      inoremap <C-s> <Esc>:w<CR>
      nnoremap <Esc> :noh<CR>

      nnoremap - :Files<CR>
      nnoremap <Leader>e :Ntree<CR>

      nnoremap <Leader>/ :Rg<CR>
      nnoremap <Leader>fr :History<CR>

      nnoremap <Leader><Leader> :Buffers<CR>
      nnoremap <S-h> :bprevious<CR>
      nnoremap <S-l> :bnext<CR>
      nnoremap <Leader>b :bd<CR>

      nnoremap <leader><tab><tab> :tabnew<cr>

      nnoremap <Leader>v :GitGutterLineHighlightsToggle<CR>

      nnoremap n nzzzv
      nnoremap N Nzzzv

      nnoremap <Leader>+ <C-a>
      nnoremap <Leader>- <C-x>

      nnoremap <C-a> ggVG
      nnoremap x "_x

      nnoremap U <C-r>

      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      let g:fzf_layout = { 'window': { 'width': 0.99, 'height': 0.99 } }
      let g:fzf_preview_window = ['right:80%', 'ctrl-/']

      highlight clear SignColumn

      augroup GitGutterCustom
        autocmd!
        autocmd ColorScheme * highlight clear SignColumn
      augroup END

      let g:gitgutter_sign_added = '+'
      let g:gitgutter_sign_modified = '~'
      let g:gitgutter_sign_removed = '-'
      let g:gitgutter_sign_removed_first_line = '-'
      let g:gitgutter_sign_removed_above_and_below = '-'
      let g:gitgutter_sign_modified_removed = '-'

      colorscheme catppuccin_macchiato
    '';
  };

  xdg.desktopEntries = mkIf pkgs.stdenv.hostPlatform.isLinux {
    vim = {
      name = "Vim";
      noDisplay = true;
    };

    gvim = {
      name = "GVim";
      noDisplay = true;
    };
  };
}
