return {
	-- Use last-used colorscheme stored in ~/.local/share/nvim/theme.txt
	{
		"rafi/theme-loader.nvim",
		lazy = false,
		priority = 99,
		opts = { initial_colorscheme = "gruvbox", fallback_colorscheme = "gruvbox" },
	},
	{ "ellisonleao/gruvbox.nvim" },

	-- All colorschemes.
	-- { "rafi/neo-hybrid.vim" },
	-- { "AlexvZyl/nordic.nvim" },
	-- { "folke/tokyonight.nvim", opts = { style = "night" } },
	-- { "rebelot/kanagawa.nvim" },
	-- { "olimorris/onedarkpro.nvim" },
	-- { "EdenEast/nightfox.nvim" },
	-- { "ribru17/bamboo.nvim" },
	--
	-- -- Soothing pastel theme
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	opts = {
	-- 		flavour = "macchiato", -- latte, frappe, macchiato, mocha
	-- 	},
	-- },
	-- { "sainnhe/gruvbox-material" },
}
