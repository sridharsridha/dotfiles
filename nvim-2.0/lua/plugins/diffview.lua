return {
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewFileHistory",
		},
		keys = {
			{ "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
			{ "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
			{ "<leader>gdt", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle Files" },
			{ "<leader>gdf", "<cmd>DiffviewFocusFiles<cr>", desc = "Focus Files" },
			{ "<leader>gdh", "<cmd>DiffviewFileHistory --follow %<cr>", desc = "File History" },
			{ "<leader>gdm", "<cmd>DiffviewOpen master<cr>", desc = "Diff with master" },
			{ "<leader>gdl", "<Cmd>.DiffviewFileHistory --follow<CR>", desc = "File history for the current line" },
			{
				"<leader>gdl",
				"<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>",
				mode = { "v" },
				desc = "File history for the visual selection",
			},
		},
      opt = {},
	},
}
