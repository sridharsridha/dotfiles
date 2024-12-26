local opt = vim.opt
---@class vim.var_accessor
local g = vim.g

local opts = {}

opts.initial = function()
	opt.laststatus = 3
	-- opt.mouse = "a"
	-- opt.path:append("**")
	opt.clipboard = "unnamedplus"
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
	opt.shiftwidth = indent
	opt.smartindent = true
	opt.tabstop = indent
	opt.expandtab = true
	opt.softtabstop = indent
	opt.sidescrolloff = indent

	-- opt.signcolumn = "auto"

	-- Statusline
	local statusline_ascii = ""
	opt.statusline = "%#Normal#" .. statusline_ascii .. "%="
end

-- Keep signcolumn on by default

-- Decrease update time
-- opt.timeoutlen = 300
-- opt.ttimeoutlen = 50

-- Preview substitutions live, as you type!
-- opt.inccommand = "split"

-- Set highlight on search
-- opt.hlsearch = true

-- opt.spell = false -- Always on spell checking
-- opt.title = false -- set terminal title to the filename and path

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
opt.wrap = true -- Display long lines as just one line
-- opt.shadafile = "NONE"

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
-- 	"netrw",
-- 	"netrwFileHandlers",
-- 	"netrwPlugin",
-- 	"netrwSettings",
-- 	"syntax",
-- 	"tohtml",
-- }
--
-- for _, plugin in pairs(disabled_built_ins) do
-- 	g["loaded_" .. plugin] = 1
-- end

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
