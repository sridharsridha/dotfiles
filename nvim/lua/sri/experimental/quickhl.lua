return {
	-- Highlight words quickly
	{
		"t9md/vim-quickhl",
		keys = {
			{
				"<leader>mt",
				"<Plug>(quickhl-manual-this)",
				mode = { "n", "x" },
				desc = "Highlight word",
			},
		},
	},
}
