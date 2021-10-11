:set clipboard=unnamedplus
:filetype plugin on
:syntax on
:set number
:set relativenumber
:filetype indent on

if $TERM == 'alacritty'
  set ttymouse=sgr
endif

vmap <C-c> "+yi
vmap <C-x> "+c
