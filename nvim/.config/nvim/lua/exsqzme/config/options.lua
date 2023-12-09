-- This file is automatically loaded by plugins.config

-- [[ Setting options ]]
-- See `:help vim.o`

-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.colorcolumn = "80" -- column highlighted with hl-ColorColumn
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs...
opt.guicursor = "" -- cursor style
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 8 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 4 -- Number of spaces tabs count for
opt.softtabstop = 4 -- INFO: defaults to 0, maybe is better
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.swapfile = false -- temporary copy of your opened buffer
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.hlsearch = false
opt.incsearch = true
opt.breakindent = true
opt.isfname:append("@-@")
opt.wildignore = opt.wildignore + "*.o,*~,*.pyc" -- Ignore compiled files
-- opt.cmdheight = 0 -- hide command-line bar when not used

opt.fillchars = {
	foldopen = "",
	foldclose = "",
	-- fold = "⸱",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

opt.shada = "!,'100,<1000,s1000,h"
-- ! save and restore global variables (ALL CAPS)
-- '100 remember marks in up to 100 files (the default value)
-- <1000 remember registers with up to 1000 lines
-- s1000 remember registers with content weighting up to 1000 kb
-- h doesnt apply highlighting on load

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldtext = "v:lua.require'exsqzme.util.ui'.foldtext()"
if vim.fn.has("nvim-0.9.0") == 1 then
	vim.opt.statuscolumn = [[%!v:lua.require'exsqzme.util.ui'.statuscolumn()]]
end

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if vim.fn.has("nvim-0.10") == 1 then
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.opt.statuscolumn = [[%!v:lua.require'exsqzme.util.ui'.statuscolumn()]]
else
	vim.opt.foldmethod = "indent"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
