-- init.lua

-- Use System Clipboard
vim.opt.clipboard = "unnamedplus"

-- Basic run commands
vim.cmd("colorscheme tender")
vim.cmd("filetype plugin on")
vim.cmd("syntax on")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.cmd("highlight Cursorline cterm=bold ctermbg=black")
vim.cmd("filetype indent on")
vim.opt.mouse = "a"
vim.opt.hlsearch = true
vim.opt.autochdir = true

-- Enable smartcase search sensitivity
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation using spaces
-- tabstop: width of tab character
-- softtabstop: fine tunes the amount of whitespace to be added
-- shiftwidth: determines the amount of whitespace to add in normal mode
-- expandtab: when on use space instead of tab
-- textwidth: text wrap width
-- autoindent: autoindent in new line
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.textwidth = 79
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Show the matching part of pairs [] {} and ()
vim.opt.showmatch = true

-- Remove trailing whitespace from Python and Fortran files
vim.api.nvim_exec([[
  autocmd BufWritePre *.py :%s/\s\+$//e
  autocmd BufWritePre *.f90 :%s/\s\+$//e
  autocmd BufWritePre *.f95 :%s/\s\+$//e
  autocmd BufWritePre *.for :%s/\s\+$//e
]], false)

if vim.fn.has('gui_running') == 1 then
  vim.opt.t_Co = 256
  vim.opt.guifont = "JetBrains Mono 11"
  vim.opt.guioptions:remove("m")
  vim.opt.guioptions:remove("T")
  vim.opt.guioptions:remove("r")
  vim.opt.guioptions:remove("L")
  vim.cmd("colorscheme tender")
end

-- Enable true colors support
vim.opt.termguicolors = true

if vim.env.TERM == "alacritty" then
  vim.opt.ttymouse = "sgr"
end

-- Keybinds for x clipboard
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', {})
vim.api.nvim_set_keymap("v", "<C-x>", '"+x', {})
vim.api.nvim_set_keymap("n", "<C-p>", '"+p', {})
vim.api.nvim_set_keymap("n", "<Leader>p", '"+P', {})

-- Vertical Motions Mappings
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true })

-- NERDTree Keybinds
vim.api.nvim_set_keymap("n", "<leader>n", ":NERDTreeFocus<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":NERDTree<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-t>", ":NERDTreeToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-f>", ":NERDTreeFind<CR>", { noremap = true })

-- Plugin manager (vim-plug)
vim.cmd [[
  call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  " Plug 'LunarWatcher/auto-pairs'
  Plug 'tmsvg/pear-tree'
  Plug 'adelarsq/vim-matchit'
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'tpope/vim-surround'
  Plug 'junegunn/fzf'
  call plug#end()
]]

-- Use a line cursor within insert mode and a block cursor everywhere else.
-- Reference chart of values:
--   Ps = 0  -> blinking block.
--   Ps = 1  -> blinking block (default).
--   Ps = 2  -> steady block.
--   Ps = 3  -> blinking underline.
--   Ps = 4  -> steady underline.
--   Ps = 5  -> blinking bar (xterm).
--   Ps = 6  -> steady bar (xterm).
vim.g.t_SI = "\27[6 q"
vim.g.t_EI = "\27[2 q"

-- Fix the cursor change timeout between insert and normal mode (see function above)
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 1
vim.opt.listchars = { tab = ">-", trail = "~", extends = ">", precedes = "<", space = "." }
vim.opt.ttyfast = true

-- Tab Autocompletion for COC.NVIM
local function check_back_space()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

vim.api.nvim_set_keymap("i", "<Tab>", "pumvisible() ? '<C-n>' : v:lua.check_back_space() ? '<Tab>' : '<Cmd>refresh()<CR>'", { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "pumvisible() ? '<C-p>' : '<C-h>'", { expr = true, noremap = true })

-- COC.NVIM colors
vim.cmd("highlight CocFloating ctermbg=0")
vim.cmd("highlight CocErrorFloat ctermfg=15")

-- Customize split dividers
vim.opt.fillchars = vim.opt.fillchars + {
  vert = "█",
  fold = "█",
  diff = "█",
  stl = "=",
  stlnc = "=",
  stl = "="
}
vim.cmd("highlight VertSplit ctermfg=235 guifg=#3c3836")
vim.cmd("highlight StatusLine ctermfg=black ctermbg=lightgray")
vim.cmd("highlight StatusLineNC ctermfg=darkgray ctermbg=lightgray")
