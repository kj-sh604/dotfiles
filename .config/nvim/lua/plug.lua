-- legacy plugin manager config (vim-plug)
vim.cmd [[
  call plug#begin()
  Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'tmsvg/pear-tree'
  Plug 'https://github.com/adelarsq/vim-matchit'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-surround'
  Plug 'sbdchd/neoformat'
  Plug 'ThePrimeagen/vim-be-good'
  Plug 'junegunn/fzf'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

  " Plug 'LunarWatcher/auto-pairs'
  call plug#end()
]]

