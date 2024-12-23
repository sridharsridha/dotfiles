local opt = vim.opt
---@class vim.var_accessor
local g = vim.g

local indent = 3
g.mapleader = " "
g.maplocalleader = ","

opt.path:append("**")

opt.lazyredraw = false
opt.termguicolors = true

-- Make line numbers default
opt.number = true
opt.relativenumber = false

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in status line
-- opt.showmode = false

-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "number"

-- Decrease update time
opt.updatetime = 500
opt.timeoutlen = 300
opt.ttimeoutlen = 50

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = false
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

opt.tabstop = indent
opt.shiftwidth = indent
opt.softtabstop = -1
opt.expandtab = true
opt.smarttab = true

-- Set highlight on search
opt.hlsearch = true

opt.textwidth = 85
opt.colorcolumn = "+1"

opt.spell = false -- Always on spell checking
opt.title = false -- set terminal title to the filename and path

-- opt.formatoptions = opt.formatoptions
-- 	- "a" -- Auto formatting is BAD.
-- 	- "t" -- Don't auto format my code. I got linters for that.
-- 	+ "c" -- In general, I like it when comments respect textwidth
-- 	+ "q" -- Allow formatting comments w/ gq
-- 	- "o" -- O and o, don't continue comments
-- 	- "r" -- Don't insert comment after <Enter>
-- 	+ "n" -- Indent past the formatlistpat, not underneath it.
-- 	+ "j" -- Auto-remove comments if possible.
-- 	- "2" -- I'm not in gradeschool anymore
-- opt.formatoptions = "qcjl1"
-- opt.virtualedit = "block" -- Allow going past the end of line in visual block mode
-- opt.completeopt = "menuone,noinsert,noselect" -- Customize completions
opt.ruler = true -- Don't show cursor position in command line
opt.wrap = true -- Display long lines as just one line
opt.shadafile = "NONE"

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	g["loaded_" .. provider .. "_provider"] = 0
end

-- -- Disable builtin plugins
-- local disabled_built_ins = {
-- 	"2html_plugin",
-- 	"bugreport",
-- 	"compiler",
-- 	"ftplugin",
-- 	"getscript",
-- 	"getscriptPlugin",
-- 	"gzip",
-- 	"logipat",
-- 	"matchit",
-- 	"optwin",
-- 	"rplugin",
-- 	"rrhelper",
-- 	"spellfile_plugin",
-- 	"synmenu",
-- 	"tar",
-- 	"tarPlugin",
-- 	"tutor",
-- 	"vimball",
-- 	"vimballPlugin",
-- 	"zip",
-- 	"zipPlugin",
--    "netrw",
--    "netrwFileHandlers",
--    "netrwPlugin",
--    "netrwSettings",
--    "syntax",
--    "tohtml",
-- }
--
-- for _, plugin in pairs(disabled_built_ins) do
-- 	g["loaded_" .. plugin] = 1
-- end
