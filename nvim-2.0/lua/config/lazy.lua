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
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	concurrency = 4,
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "catppuccin" },
	},
	dev = {
		path = vim.env.NVIM_DEV,
	},
	-- automatically check for plugin updates
	-- checker = { enabled = true },
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true,
		rtp = {
			disabled_plugins = {
				"osc52",
				"parser",
				"gzip",
				"netrwPlugin",
				"health",
				"man",
				"matchit",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"shadafile",
				"spellfile",
				"editorconfig",
			},
		},
	},
	ui = {
		border = "solid",
		title = "lazy.nvim",
		size = { width = 0.9, height = 0.9 },
	},
})
