local opt = vim.opt
---@class vim.var_accessor
local g = vim.g

local opts = {}

opts.initial = function()
	opt.path:append("**")
	opt.pumblend = 0
	-- opt.laststatus = 3
	opt.showmode = false
	opt.lazyredraw = false
	opt.clipboard = "unnamed,unnamedplus"
	opt.termguicolors = true
	opt.lazyredraw = false
	opt.fillchars:append({ eob = " " })
	opt.shortmess:append("aoOt")
	opt.cursorline = true
	opt.cursorlineopt = "number"
	opt.ruler = true
	opt.textwidth = 85
	opt.spell = false -- Always on spell checking
	opt.title = true -- set terminal title to the filename and path
	opt.colorcolumn = "+1"
	opt.number = true
	opt.relativenumber = false
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
	opt.formatoptions = "2qcjl1o"
	opt.virtualedit = "block" -- Allow going past the end of line in visual block mode
	opt.breakindent = true
	opt.list = false
	-- Preview substitutions live, as you type!
	-- Set highlight on search
	opt.hlsearch = true
	opt.inccommand = "split"
	opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
	opt.linebreak = true
	opt.swapfile = false
	opt.undofile = true
	opt.cmdheight = 1
	g.winblend = 0
	local gl = require("config/global")
	g.mapleader = gl.mapleader
	g.maplocalleader = gl.maplocalleader
	g.netrw_silent = gl.netrw_silent
	g.disable_autoformat = gl.disable_autoformat
	g.use_icons = gl.use_icons
	-- Disable providers
	g.loaded_node_provider = 0
	g.loaded_python3_provider = 0
	g.loaded_perl_provider = 0
	g.loaded_ruby_provider = 0

	opt.wrap = true
	opt.completeopt = { "menuone", "noselect", "noinsert" }
	opt.wildmenu = true
	opt.pumheight = 10
	opt.ignorecase = true
	opt.smartcase = true
	opt.timeout = false
	opt.updatetime = 400
	-- opt.confirm = false
	opt.equalalways = false
	opt.splitbelow = true
	opt.splitright = true
	opt.scrolloff = 2
	-- Indenting
	local indent = 3
	opt.tabstop = indent
	opt.shiftwidth = indent
	opt.smartindent = true
	opt.expandtab = true
	opt.softtabstop = -1
	opt.sidescrolloff = indent
end

opts.final = function() end

--- Load shada after ui-enter
local shada = vim.o.shada
vim.o.shada = ""
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.o.shada = shada
		pcall(vim.cmd.rshada, { bang = true })
	end,
})

vim.diagnostic.config({
	virtual_text = {
		prefix = "",
		suffix = "",
		format = function(diagnostic)
			return " " .. diagnostic.message .. " "
		end,
	},
	underline = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	signs = {
		text = {
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.WARN] = "",
		},
	},
})

return opts
