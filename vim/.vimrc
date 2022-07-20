syntax on

set scrolloff=8
set number
set relativenumber
set expandtab
set tabstop=2 softtabstop=2
set shiftwidth=2
set smartindent
set mouse=a

if (has("termguicolors"))
  set termguicolors
endif
set t_Co=16
" Correct RGB escape codes for vim inside tmux
if !has('nvim') && $TERM ==# 'tmux-256color'
 let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
 let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
if (empty($IS_DARK))
  set background=light
else
  set background=dark
endif
highlight Comment cterm=italic gui=italic
colorscheme selenized
