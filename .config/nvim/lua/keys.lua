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
vim.api.nvim_set_keymap("n", "<C-t>", ":NERDTreeToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>/", ":NERDTreeFind<CR>", { noremap = true })
