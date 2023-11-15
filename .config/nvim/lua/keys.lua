-- legacy keybinds for x11 clipboard
vim.cmd [[
  vnoremap <C-c> "+y
  vmap <C-x> "+x
  map <C-p> "+p
  map <Leader>p "+P
]]

-- vertical motion remappings
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true })

-- nerdtree keybinds
vim.api.nvim_set_keymap("n", "<leader>n", ":NERDTreeFocus<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":NERDTree<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-n>", ":NERDTreeToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>/", ":NERDTreeFind<CR>", { noremap = true })

-- spell check keybinds
vim.api.nvim_set_keymap("n", "<leader>sc", ":set spell!<CR>", { silent = true })

-- splits and vsplits creation rebinds
vim.api.nvim_set_keymap('n', '<A-s>', '<C-W>v', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-d>', '<C-W>s', { noremap = true })

-- splits quit and save&quit
vim.api.nvim_set_keymap('n', '<A-q>', 'ZQ', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-z>', 'ZZ', { noremap = true })

-- splits and vsplits movement rebinds
vim.api.nvim_set_keymap('n', '<A-j>', '<C-W>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-k>', '<C-W>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-l>', '<C-W>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-h>', '<C-W>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-e>', '<C-W>w', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-w>', '<C-W>W', { noremap = true })

-- splits and vsplits resize rebinds
vim.api.nvim_set_keymap('n', '<A-,>', '<C-W>5<', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-.>', '<C-W>5>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-->', '<C-W>5-', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-=>', '<C-W>5+', { noremap = true })

-- tab rebinds
vim.api.nvim_set_keymap('n', '<A-t>', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-[>', ':tabprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-]>', ':tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-;>', ':tabmove -<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-\'>', ':tabmove +<CR>', { noremap = true })

-- set file type keybind
vim.api.nvim_set_keymap('n', '<leader>ft', ':set filetype=', { noremap = true })
