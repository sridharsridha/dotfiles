-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup("plugins", {
	concurrency = 8,
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "rose-pine", "catppuccin" },
	},
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"parser",
				"gzip",
				"health",
				"man",
				"rplugin",
				"tohtml",
				"spellfile",
				"editorconfig",
				"fileExplorer",
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"logipat",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
	rocks = {
		enabled = false,
	},
	ui = {
		-- border = "none",
		title = "lazy.nvim",
		size = { width = 0.9, height = 0.9 },
		-- icons = {},
	},
	change_detection = {
		-- enabled = false,
	},
})
