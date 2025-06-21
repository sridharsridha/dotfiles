return {
	{
		"folke/todo-comments.nvim",
      event = { "BufReadPost", "BufNewFile" },
		cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickfix" }, -- Load only when these commands are run
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next Todo Comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous Todo Comment",
			},
			{ "<leader>ft", "<cmd>TodoTrouble<cr>", desc = "Find Todo (Trouble)" },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
         signs = true,
		},
	},
}
