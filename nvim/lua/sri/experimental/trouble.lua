return {
	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
		opts = {},
		keys = {
			{
				"<leader>e",
				function()
					require("trouble").toggle("diagnostics")
				end,
				desc = "Diagnostics (Trouble)",
			},
		},
	},
}
