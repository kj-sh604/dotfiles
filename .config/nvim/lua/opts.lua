local opts = {
    -- clipboard = "unnamedplus",
    -- textwidth = 80,
    autochdir = true,
    autoindent = true,
    cursorline = true,
    expandtab = true,
    hlsearch = true,
    ignorecase = true,
    listchars = { tab = ">-", trail = "~", extends = ">", precedes = "<", space = "." },
    linebreak = true,
    mouse = "a",
    number = true,
    relativenumber = true,
    shiftwidth = 4,
    showmatch = true,
    smartcase = true,
    softtabstop = 4,
    tabstop = 4,
    termguicolors = true,
    ttimeout = true,
    ttimeoutlen = 1,
    ttyfast = true,
}

-- customize split dividers
vim.opt.fillchars = vim.opt.fillchars + {
  vert = "█",
  fold = "█",
  diff = "█",
  stl = "=",
  stlnc = "=",
  stl = "="
}

-- use a line cursor within insert mode and a block cursor everywhere else.
-- reference chart of values:
--   ps = 0  -> blinking block.
--   ps = 1  -> blinking block (default).
--   ps = 2  -> steady block.
--   ps = 3  -> blinking underline.
--   ps = 4  -> steady underline.
--   ps = 5  -> blinking bar (xterm).
--   ps = 6  -> steady bar (xterm).
vim.g.t_SI = "\27[6 q"
vim.g.t_EI = "\27[2 q"

if vim.env.TERM == "alacritty" then
  vim.opt.ttymouse = "sgr"
end

for x, y in pairs(opts) do
  vim.opt[x] = y
end
