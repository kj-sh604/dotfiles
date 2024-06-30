local opts = {
    -- clipboard = "unnamedplus",
    -- textwidth = 80,
    autochdir = true,
    autoindent = true,
    cursorline = true,
    expandtab = true,
    hlsearch = true,
    ignorecase = true,
    linebreak = true,
    listchars = { tab = ">-", trail = "~", extends = ">", precedes = "<", space = "." },
    mouse = "a",
    number = true,
    relativenumber = true,
    shiftwidth = 4,
    showmatch = true,
    smartcase = true,
    softtabstop = 4,
    splitbelow = true,
    splitright = true,
    tabstop = 4,
    termguicolors = true,
    ttimeout = true,
    ttimeoutlen = 1,
    ttyfast = true,
    undofile = true,
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

for k, v in pairs(opts) do
  vim.opt[k] = v
end
