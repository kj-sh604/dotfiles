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
colorscheme one
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
" set textwidth	=79
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
  colorscheme evening
endif

" enable true colors support "
set termguicolors

if $TERM == 'alacritty'
  set ttymouse=sgr
endif

" ╦╔═┌─┐┬ ┬┌┐ ┬┌┐┌┌┬┐┌─┐  ┌─┐┌─┐┬─┐  ═╗ ╦  ╔═╗┬  ┬┌─┐┌┐ ┌─┐┌─┐┬─┐┌┬┐
" ╠╩╗├┤ └┬┘├┴┐││││ ││└─┐  ├┤ │ │├┬┘  ╔╩╦╝  ║  │  │├─┘├┴┐│ │├─┤├┬┘ ││
" ╩ ╩└─┘ ┴ └─┘┴┘└┘─┴┘└─┘  └  └─┘┴└─  ╩ ╚═  ╚═╝┴─┘┴┴  └─┘└─┘┴ ┴┴└──┴┘

vnoremap <C-c> "+y
vmap <C-x> "+x
map <C-p> "+p
map <Leader>p "+P

" Vertical Motions Mappings
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

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
" Plug 'LunarWatcher/auto-pairs'
Plug 'tmsvg/pear-tree'
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'sbdchd/neoformat'
Plug 'ThePrimeagen/vim-be-good'
Plug 'junegunn/fzf'
call plug#end()

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Fix the cursor change timeout between insert and normal mode (see function
" above)
"
"
set ttimeout
set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

" Tab Autocompletion for COC NVIM
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" COC.NVIM colors
highlight CocFloating ctermbg=0
highlight CocErrorFloat ctermfg=15
