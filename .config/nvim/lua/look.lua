-- colorscheme declaration
vim.cmd("colorscheme tender")

-- coc.nvim colors
vim.cmd("highlight CocFloating ctermbg=0")
vim.cmd("highlight CocErrorFloat ctermfg=15")

-- appearance of splits and vsplits
vim.cmd("highlight VertSplit ctermfg=235 guifg=#3c3836")
vim.cmd("highlight StatusLine ctermfg=black ctermbg=lightgray")
vim.cmd("highlight StatusLineNC ctermfg=darkgray ctermbg=lightgray")

-- gui appearance declarations
if vim.fn.has('gui_running') == 1 then
  vim.opt.t_Co = 256
  vim.opt.guifont = "JetBrains Mono 11"
  vim.opt.guioptions:remove("m")
  vim.opt.guioptions:remove("T")
  vim.opt.guioptions:remove("r")
  vim.opt.guioptions:remove("L")
  vim.cmd("colorscheme tender")
end

-- remove trailing whitespace from python and fortran files
vim.api.nvim_exec([[
  autocmd BufWritePre *.py :%s/\s\+$//e
  autocmd BufWritePre *.f90 :%s/\s\+$//e
  autocmd BufWritePre *.f95 :%s/\s\+$//e
  autocmd BufWritePre *.for :%s/\s\+$//e
]], false)

-- other appearance settings that I don't know how to set in lua 
vim.cmd("filetype plugin on")
vim.cmd("syntax on")
vim.cmd("highlight Cursorline cterm=bold ctermbg=black")
vim.cmd("filetype indent on")

