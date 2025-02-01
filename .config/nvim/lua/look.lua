-- colorscheme declaration
vim.cmd("colorscheme tender")

-- coc.nvim colors
vim.cmd("highlight CocFloating ctermbg=0")
vim.cmd("highlight CocErrorFloat ctermfg=15")

-- gui appearance declarations
if vim.fn.has('gui_running') == 1 then
  vim.opt.t_Co = 256
  vim.opt.guifont = "Roboto Mono 11"
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
-- set the text color of the line numbers
vim.cmd('highlight LineNr guifg=darkgray ctermfg=darkgray')
-- set the text color for the current line number
vim.cmd('highlight CursorLineNr guifg=cyan ctermfg=cyan')

-- customize split dividers
vim.opt.fillchars = vim.opt.fillchars + {
  vert = "█",
  fold = "█",
  diff = "█",
  stl = "-",
  stlnc = "-",
  stl = "-"
}

-- set statusline colors
vim.cmd([[
  hi VertSplit guifg=#151515
  hi User1 guifg=#999999 guibg=#151515
  hi User2 guifg=#eea040 guibg=#151515
  hi User3 guifg=#0072ff guibg=#151515
  hi User4 guifg=#ffffff guibg=#151515
  hi User5 guifg=#777777 guibg=#151515
]])

-- set statusline
vim.o.statusline = table.concat({
  "%1* %n %*",       -- buffer number
  "%3* %y %*",       -- file type
  -- "%4* %<%F %*",  -- full path
  "%4* %<%f %*",     -- file name 
  "%2* %m %*",       -- modified flag
  "%1* %= %5l %*",   -- current line
  "%2* /%L %*",      -- total lines
  "%1* %4v %*",      -- virtual column number
  "%2* 0x%04B %*",   -- character under cursor
  "%5* %{&ff} %*",   -- file format
})
