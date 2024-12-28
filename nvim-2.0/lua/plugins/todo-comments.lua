return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		event = "BufRead",
		keys = {
			{ "<leader>ct", "<cmd>Trouble todo<cr>", desc = "todo comments" },
		},
	},
}
