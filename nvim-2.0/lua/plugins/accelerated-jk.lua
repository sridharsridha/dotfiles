return {
	{
		"rainbowhxch/accelerated-jk.nvim",
		event = "VeryLazy",
		config = function()
			require("accelerated-jk").setup({
				mode = "time_driven",
				enable_deceleration = false,
				acceleration_motions = {},
				acceleration_limit = 150,
				acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
				-- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
				deceleration_table = { { 150, 9999 } },
			})
			vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
			vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
		end,
	},
}
