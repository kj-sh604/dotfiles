-- plugins
vim.cmd [[
	call plug#begin()
	Plug 'github/copilot.vim'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'https://github.com/adelarsq/vim-matchit'
	Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'j-hui/fidget.nvim'
	Plug 'junegunn/fzf'
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
	Plug 'sbdchd/neoformat'
	Plug 'tmsvg/pear-tree'
	Plug 'tpope/vim-surround'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'williamboman/mason.nvim'
	Plug 'ThePrimeagen/vim-be-good'
	Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
	call plug#end()
]]

vim.g.NERDTreeShowHidden = 1
vim.g.pear_tree_ft_disabled = { "TelescopePrompt", "TelescopeResults" }

-- options
local opts = {
	autochdir = true,
	autoindent = true,
	autoread = true,
	backup = false,
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
	signcolumn = "yes",
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
	updatetime = 300,
	writebackup = false,
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end

-- spell and cursor shape
vim.opt.spelllang = { "en_us", "tl" }
vim.g.t_SI = "\27[6 q"
vim.g.t_EI = "\27[2 q"

-- terminal tweaks
if vim.env.TERM == "alacritty" then
	vim.opt.ttymouse = "sgr"
end

-- custom functions for keymaps
local term_buf = nil
local toggle_terminal
toggle_terminal = function()
    if term_buf and vim.fn.bufexists(term_buf) == 1 then
        local win = vim.fn.bufwinnr(term_buf)
        if win ~= -1 then
            vim.cmd(win .. "close")
            return
        end
        vim.cmd("belowright split")
        vim.cmd("resize " .. math.floor(vim.o.lines / 3))
        vim.cmd("buffer " .. term_buf)
        vim.cmd("startinsert")
        return
    end
    vim.cmd("belowright split")
    vim.cmd("resize " .. math.floor(vim.o.lines / 3))
    vim.cmd("terminal")
    vim.cmd("startinsert")
    term_buf = vim.api.nvim_get_current_buf()
end

-- custom keymaps
local keymap = vim.keymap.set

keymap("v", "<C-c>", '"+y', { noremap = true })
keymap("v", "<C-x>", '"+x', { noremap = true })
keymap({ "n", "v" }, "<C-p>", '"+p', { noremap = true })
keymap({ "n", "v" }, "<leader>p", '"+P', { noremap = true })
keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
keymap("n", "<C-u>", "<C-u>zz", { noremap = true })
keymap("n", "n", "nzzzv", { noremap = true })
keymap("n", "N", "Nzzzv", { noremap = true })

keymap("n", "<S-A-b>h", ":NERDTreeToggle<CR>", { noremap = true })
keymap("n", "<S-A-b><S-A-h>", ":NERDTreeToggle<CR>", { noremap = true })
keymap("n", "<A-n>", ":NERDTreeToggle<CR>", { noremap = true })
keymap("n", "<S-A-n>", ":NERDTree<CR>", { noremap = true })
keymap("n", "<S-A-j>", "<C-W>w", { noremap = true })
keymap("n", "<S-A-k>", "<C-W>W", { noremap = true })
keymap({"n", "t"}, "<S-A-b>j", function() toggle_terminal() end, { noremap = true })
keymap({"n", "t"}, "<S-A-b><S-A-j>", function() toggle_terminal() end, { noremap = true })
keymap("n", "<leader>sc", ":set spell!<CR>", { noremap = true, silent = true })

keymap("n", "<A-j>", ":bnext<CR>", { noremap = true, silent = true })
keymap("n", "<A-k>", ":bprev<CR>", { noremap = true, silent = true })

keymap("n", "<A-q>", "ZQ", { noremap = true })
keymap("n", "<A-z>", "ZZ", { noremap = true })

keymap("n", "<A-,>", "<C-W>5<", { noremap = true })
keymap("n", "<A-.>", "<C-W>5>", { noremap = true })
keymap("n", "<A-->", "<C-W>5-", { noremap = true })
keymap("n", "<A-=>", "<C-W>5+", { noremap = true })

keymap("n", "<A-s>", ":vsplit<CR>", { noremap = true })
keymap("n", "<A-d>", ":split<CR>", { noremap = true })

keymap("n", "<A-t>", ":tabnew<CR>", { noremap = true })
keymap("n", "<A-[>", ":tabprev<CR>", { noremap = true })
keymap("n", "<A-]>", ":tabnext<CR>", { noremap = true })
keymap("n", "<A-;>", ":tabmove -<CR>", { noremap = true })
keymap("n", "<A-'>", ":tabmove +<CR>", { noremap = true })
keymap("n", "<leader>ft", ":set filetype=", { noremap = true })

-- copilot
keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true, replace_keycodes = false })

-- ui and colors
vim.cmd("colorscheme kijish")

if vim.fn.has("gui_running") == 1 then
	vim.opt.t_Co = 256
	vim.opt.guifont = "Roboto Mono 11"
	vim.opt.guioptions:remove("m")
	vim.opt.guioptions:remove("T")
	vim.opt.guioptions:remove("r")
	vim.opt.guioptions:remove("L")
	vim.cmd("colorscheme tender")
end

-- autocmds
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.py", "*.f90", "*.f95", "*.for" },
	command = [[%s/\s\+$//e]],
})

local autoread_group = vim.api.nvim_create_augroup("autoread", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	group = autoread_group,
	command = "if mode() !~ '\''[cCeEsS]'\'' | checktime | endif",
})

vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")
vim.cmd("syntax on")
vim.cmd("highlight Cursorline cterm=bold ctermbg=black")
vim.cmd("highlight LineNr guifg=darkgray ctermfg=darkgray")
vim.cmd("highlight CursorLineNr guifg=cyan ctermfg=cyan")

vim.opt.fillchars = vim.opt.fillchars + {
	vert = "█",
	fold = "█",
	diff = "█",
	stl = "-",
	stlnc = "-",
}

vim.cmd([[
	hi VertSplit guifg=#151515
	hi User1 guifg=#999999 guibg=#151515
	hi User2 guifg=#eea040 guibg=#151515
	hi User3 guifg=#0072ff guibg=#151515
	hi User4 guifg=#ffffff guibg=#151515
	hi User5 guifg=#777777 guibg=#151515
]])

-- statusline
vim.o.statusline = table.concat({
	"%1* %n %*",
	"%3* %y %*",
	"%4* %<%f %*",
	"%2* %m %*",
	"%1* %= %5l %*",
	"%2* /%L %*",
	"%1* %4v %*",
	"%2* 0x%04B %*",
	"%5* %{&ff} %*",
})

-- telescope
local tele_ok, builtin = pcall(require, "telescope.builtin")
if tele_ok then
	keymap("n", "<leader>fg", function()
		builtin.live_grep({
			find_command = { "rg", "--ignore", "--hidden", "--files" },
			prompt_prefix = " search:  ",
		})
	end, {})

	keymap("n", "<leader>ff", function()
		builtin.find_files({
			find_command = { "rg", "--ignore", "--hidden", "--files" },
			prompt_prefix = " search:  ",
		})
	end, {})

	keymap("n", "<leader>fb", function()
		builtin.buffers({
			prompt_prefix = " search:  ",
		})
	end, {})

	keymap("n", "<leader>fh", function()
		builtin.help_tags({
			prompt_prefix = " search:  ",
		})
	end, {})
end

-- lsp
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = true,
})

keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "diagnostic prev" })
keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "diagnostic next" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "diagnostic float" })
keymap("n", "<C-k><C-i>", vim.diagnostic.open_float, { desc = "diagnostic float" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "diagnostic list" })
keymap("n", "<S-A-m>", vim.diagnostic.setloclist, { desc = "diagnostic list" })


vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "lsp: " .. desc })
		end

		map("grn", vim.lsp.buf.rename, "rename")
		map("gra", vim.lsp.buf.code_action, "code action", { "n", "x" })
		map("grD", vim.lsp.buf.declaration, "declaration")
		map("gri", vim.lsp.buf.implementation, "implementation")
		map("grr", vim.lsp.buf.references, "references")
		map("grd", vim.lsp.buf.definition, "definition")
		map("grt", vim.lsp.buf.type_definition, "type definition")
		map("K", vim.lsp.buf.hover, "hover")
		map("<leader>F", function() vim.lsp.buf.format({ async = true }) end, "format", { "n", "x" })

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local highlight_group = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_group,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_group,
				callback = vim.lsp.buf.clear_references,
			})
		end

		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "toggle inlay hints")
		end
	end,
})

local ok_fidget, fidget = pcall(require, "fidget")
if ok_fidget then
	fidget.setup({})
end

local ok_mason, mason = pcall(require, "mason")
local ok_mlsp, mason_lspconfig = pcall(require, "mason-lspconfig")
local ok_tools, mason_tool_installer = pcall(require, "mason-tool-installer")

-- put lsp servers here to ensure they are installed and configured
local servers = {
	bashls = {},
	clangd = {},
	dockerls = {},
	docker_compose_language_service = {},
	html = {},
	cssls = {},
	ts_ls = {},
	intelephense = {},
	pylsp = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				diagnostics = { globals = { "vim" } },
				workspace = {
					checkThirdParty = false,
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = { enable = false },
			},
		},
	},
}

if ok_mason then
	mason.setup()
end

if ok_tools then
	mason_tool_installer.setup({ ensure_installed = vim.tbl_keys(servers) })
end

if ok_mlsp then
	mason_lspconfig.setup({
		ensure_installed = vim.tbl_keys(servers),
		automatic_installation = true,
	})
end

for server_name, server_config in pairs(servers) do
	vim.lsp.config(server_name, server_config)
	vim.lsp.enable(server_name)
end

-- completion
vim.opt.completeopt = { "menu", "menuone", "noinsert" }

local ok_cmp, cmp = pcall(require, "cmp")
if ok_cmp then
	cmp.setup({
		mapping = cmp.mapping.preset.insert({
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
		}, {
			{ name = "buffer" },
			{ name = "path" },
		}),
	})
end
