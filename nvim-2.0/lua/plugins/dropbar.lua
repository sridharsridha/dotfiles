return {
	{
		"Bekaboo/dropbar.nvim",
		name = "dropbar",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
		},
		keys = {
			{
				"<leader>;",
				function()
					require("dropbar.api").pick(vim.v.count ~= 0 and vim.v.count)
				end,
				desc = "pick symbols in winbar",
			},
			{
				"[;",
				function()
					require("dropbar.api").goto_context_start()
				end,
				desc = "start of winbar current context",
			},
			{
				"];",
				function()
					require("dropbar.api").select_next_context()
				end,
				desc = "Select winbar next context",
			},
		},
	},
}
