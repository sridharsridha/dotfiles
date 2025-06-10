local opt = vim.opt
---@class vim.var_accessor
local g = vim.g
local gl = require("config/global")

local opts = {}

opts.initial = function()
	opt.path:append("**")
	opt.pumblend = 0
	opt.showmode = false
	opt.lazyredraw = false
	opt.clipboard = "unnamed,unnamedplus"
	opt.termguicolors = true
	opt.laststatus = 2
	opt.shortmess:append("aoOt")
	opt.cursorline = true
	opt.number = true
	opt.relativenumber = false
	opt.hlsearch = true
	opt.inccommand = "split"
	opt.swapfile = false
	opt.undofile = true
	opt.undodir = vim.fn.stdpath("data") .. "/undodir"
	opt.cmdheight = 1
	opt.completeopt = { "menuone", "noselect", "noinsert" }
	opt.ignorecase = true
	opt.smartcase = true
	opt.timeoutlen = 300
	opt.updatetime = 400
	opt.splitbelow = true
	opt.splitright = true
	opt.scrolloff = 8
	opt.signcolumn = "yes"
	opt.tabstop = gl.indent
	opt.shiftwidth = gl.indent
	opt.expandtab = true
	g.mapleader = gl.mapleader
end

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
