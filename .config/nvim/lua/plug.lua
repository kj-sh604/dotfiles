-- Plugin manager (vim-plug)
vim.cmd [[
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
]]

