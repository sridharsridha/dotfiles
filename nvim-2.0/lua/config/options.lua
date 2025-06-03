local opt = vim.opt
---@class vim.var_accessor
local g = vim.g
local gl = require("config/global")

local opts = {}
local gl = require("config/global")

opts.initial = function()
	opt.path:append("**")
	opt.pumblend = 0
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
	opt.relativenumber = true
	opt.formatoptions = "2qcjl1o"
	opt.virtualedit = "block"
	opt.breakindent = true
	opt.list = false
	opt.hlsearch = true
	opt.inccommand = "split"
	opt.linebreak = true
	opt.swapfile = false
	opt.undofile = true
	opt.cmdheight = 1
	g.winblend = 0

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
	opt.equalalways = false
	opt.splitbelow = true
	opt.splitright = true
	opt.scrolloff = 2
	opt.tabstop = gl.indent
	opt.shiftwidth = gl.indent
	opt.expandtab = true
	opt.sidescrolloff = gl.indent

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
			return "- " .. diagnostic.message .. " "
		end,
	},
})

return opts
