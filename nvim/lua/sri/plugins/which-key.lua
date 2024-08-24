return {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		keys = {
			"<leader>",
			"<localleader>",
			"\\",
			"<c-w>",
			'"',
			"'",
			"`",
			"c",
			"v",
			"g",
			"z",
			"<",
			">",
			"s",
		},
		cmd = "WhichKey",
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup({
				preset = "helix",
				win = {
					border = "none",
					padding = { 1, 2 },
				},
				icons = {
					mappings = false,
					rules = false,
					colors = false,
				},
				show_help = false,
			})
		end,
	},
}
