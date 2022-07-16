"        ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄▄ 
"       █  █ █  █   █  █▄█  █   ▄  █ █       █
"       █  █▄█  █   █       █  █ █ █ █       █
"       █       █   █       █   █▄▄█▄█     ▄▄█
"   ▄▄▄ █       █   █       █    ▄▄  █    █   
"  █   █ █     ██   █ ██▄██ █   █  █ █    █▄▄ 
"  █▄▄▄█  █▄▄▄█ █▄▄▄█▄█   █▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█

" Use System Clipboard
":set clipboard=unnamedplus

" ┌┐ ┌─┐┌─┐┬┌─┐  ┬─┐┬ ┬┌┐┌  ┌─┐┌─┐┌┬┐┌┬┐┌─┐┌┐┌┌┬┐┌─┐
" ├┴┐├─┤└─┐││    ├┬┘│ ││││  │  │ │││││││├─┤│││ ││└─┐
" └─┘┴ ┴└─┘┴└─┘  ┴└─└─┘┘└┘  └─┘└─┘┴ ┴┴ ┴┴ ┴┘└┘─┴┘└─┘

filetype plugin on
syntax on
set number
set relativenumber
set cursorline
:highlight Cursorline cterm=bold ctermbg=black
filetype indent on
set mouse=a
set hlsearch

" enable smartcase search sensitivity "
set ignorecase
set smartcase

" Indentation using spaces "
" tabstop:	width of tab character
" softtabstop:	fine tunes the amount of whitespace to be added
" shiftwidth:	determines the amount of whitespace to add in normal mode
" expandtab:	when on use space instead of tab
" textwidth:	text wrap width
" autoindent:	autoindent in new line
set tabstop	=4
set softtabstop	=4
set shiftwidth	=4
set textwidth	=79
set expandtab
set autoindent

" show the matching part of pairs [] {} and () "
set showmatch

" remove trailing whitespace from Python and Fortran files "
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.f90 :%s/\s\+$//e
autocmd BufWritePre *.f95 :%s/\s\+$//e
autocmd BufWritePre *.for :%s/\s\+$//e

if has('gui_running')
  set t_Co=256
  set guifont=JetBrains\ Mono\ 11
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  colorscheme slate
endif

" enable true colors support "
"set termguicolors

if $TERM == 'alacritty'
  set ttymouse=sgr
endif

" ╦╔═┌─┐┬ ┬┌┐ ┬┌┐┌┌┬┐┌─┐  ┌─┐┌─┐┬─┐  ═╗ ╦  ╔═╗┬  ┬┌─┐┌┐ ┌─┐┌─┐┬─┐┌┬┐
" ╠╩╗├┤ └┬┘├┴┐││││ ││└─┐  ├┤ │ │├┬┘  ╔╩╦╝  ║  │  │├─┘├┴┐│ │├─┤├┬┘ ││
" ╩ ╩└─┘ ┴ └─┘┴┘└┘─┴┘└─┘  └  └─┘┴└─  ╩ ╚═  ╚═╝┴─┘┴┴  └─┘└─┘┴ ┴┴└──┴┘

vnoremap <C-c> "+y
vmap <C-x> "+c
map <C-p> "+p

" NERDTree Keybinds
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" ╔═╗┬  ┬ ┬┌─┐┬┌┐┌  ╔╦╗┌─┐┌┐┌┌─┐┌─┐┌─┐┬─┐
" ╠═╝│  │ ││ ┬││││  ║║║├─┤│││├─┤│ ┬├┤ ├┬┘
" ╩  ┴─┘└─┘└─┘┴┘└┘  ╩ ╩┴ ┴┘└┘┴ ┴└─┘└─┘┴└─

call plug#begin()
Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'LunarWatcher/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf'
call plug#end()

