:set clipboard=unnamedplus
:filetype plugin on
:syntax on
:set number
:set relativenumber
:filetype indent on
:set mouse=a

if $TERM == 'alacritty'
  set ttymouse=sgr
endif

vmap <C-c> "+yi
vmap <C-x> "+c
