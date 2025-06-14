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
			{ "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
			{ "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
			{ "<leader>dt", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle Files" },
			{ "<leader>df", "<cmd>DiffviewFocusFiles<cr>", desc = "Focus Files" },
			{ "<leader>dh", "<cmd>DiffviewFileHistory --follow %<cr>", desc = "File History" },
			{ "<leader>dm", "<cmd>DiffviewOpen master<cr>", desc = "Diff with master" },
			{ "<leader>dl", "<Cmd>.DiffviewFileHistory --follow<CR>", desc = "File history for the current line" },
			{
				"<leader>dl",
				"<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>",
				mode = { "v" },
				desc = "File history for the visual selection",
			},
		},
		config = function()
			local actions = require("diffview.actions")
			require("diffview").setup({
                use_icons = require("config/global").use_icons,
			})
		end,
	},
}
