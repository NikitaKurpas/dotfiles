syntax on

set scrolloff=8
set number
set relativenumber
set expandtab
set tabstop=2 softtabstop=2
set shiftwidth=2
set smartindent

set termguicolors
set t_Co=16
" Correct RGB escape codes for vim inside tmux
if !has('nvim') && $TERM ==# 'tmux-256color'
 let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
 let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
highlight Comment cterm=italic gui=italic
set background=dark
colorscheme selenized
