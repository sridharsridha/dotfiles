local opt = vim.opt
---@class vim.var_accessor
local g = vim.g

local opts = {}

opts.initial = function()
	opt.laststatus = 3
	opt.clipboard = "unnamed,unnamedplus"
	opt.termguicolors = true
	opt.lazyredraw = false
	opt.fillchars:append({ eob = " " })
	opt.shortmess:append("aIF")
	opt.cursorline = true
	opt.cursorlineopt = "number"
	opt.ruler = true
	opt.textwidth = 85
	opt.colorcolumn = "+1"
	opt.number = true
	opt.relativenumber = false
	opt.breakindent = true
	opt.linebreak = true
	opt.swapfile = false
	opt.undofile = true
	opt.cmdheight = 0
	g.border_style = "single" ---@type "single"|"double"|"rounded"
	g.winblend = 0
	g.mapleader = " "
	g.maplocalleader = ","
	-- Disable providers
	g.loaded_node_provider = 0
	g.loaded_python3_provider = 0
	g.loaded_perl_provider = 0
	g.loaded_ruby_provider = 0
end

opts.final = function()
	opt.wrap = false
	opt.completeopt = { "menuone", "noselect", "noinsert" }
	opt.wildmenu = true
	opt.pumheight = 10
	opt.ignorecase = true
	opt.smartcase = true
	opt.timeout = false
	opt.updatetime = 400
	opt.confirm = false
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
			[vim.diagnostic.severity.HINT] = "*",
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.INFO] = "◉",
			[vim.diagnostic.severity.WARN] = "!",
		},
	},
})

return opts
