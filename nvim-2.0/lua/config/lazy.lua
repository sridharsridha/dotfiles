-- ╭─────────────────────────────────────────────────────────╮
-- │ Lazy.nvim Plugin Manager Configuration                  │
-- │ Bootstrap and setup for lazy loading plugins            │
-- ╰─────────────────────────────────────────────────────────╯

-- ╭─────────────────────────────────────────────────────────╮
-- │ Bootstrap lazy.nvim                                     │
-- ╰─────────────────────────────────────────────────────────╯
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	-- Auto-install lazy.nvim if not present
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

-- ╭─────────────────────────────────────────────────────────╮
-- │ Lazy.nvim Setup                                         │
-- ╰─────────────────────────────────────────────────────────╯
require("lazy").setup("plugins", {
	-- Performance settings
	concurrency = 8, -- Limit concurrent operations (custom: helps with system stability)
	defaults = {
		lazy = true, -- Lazy load all plugins by default
	},
	install = {
		colorscheme = { "catppuccin", "rose-pine" }, -- Fallback colorschemes during install
	},
	performance = {
		cache = {
			enabled = true, -- Enable module caching for faster startup
		},
		rtp = {
			-- Disable unused built-in plugins for faster startup
			disabled_plugins = {
				-- Archive formats
				"gzip",
				"tar",
				"tarPlugin",
				"zip",
				"zipPlugin",
				"vimball",
				"vimballPlugin",

				-- Neovim utilities we don't use
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"logipat",
				"rrhelper",
				"spellfile",
				"spellfile_plugin",

				-- Built-in features we replace or don't need
				"matchit",       -- Replaced by vim-matchup or treesitter
				"netrwPlugin",   -- Using telescope/neo-tree instead
				"netrw",         -- File explorer (replaced)
				"tutor",         -- Tutorial plugin
				"rplugin",       -- Remote plugin host

				-- UI/Menu items
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
	rocks = {
		enabled = false, -- Disable luarocks integration (not needed)
	},
	ui = {
		-- title = "lazy.nvim", -- Default title, removed redundancy
		size = { width = 0.9, height = 0.9 }, -- Custom: larger UI window
	},
})
