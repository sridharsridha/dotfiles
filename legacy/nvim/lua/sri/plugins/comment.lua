return {
	{
		-- Fast and familiar per-line commenting
		"numToStr/Comment.nvim",
		event = { "InsertEnter" },
		opts = {},
	},
	-- Type :CB and get completion, use CBllbox 10
	{
		"LudoPinelli/comment-box.nvim",
		enabled = false,
		event = "InsertEnter",
		keys = {
			{ "gB", "<cmd>lua require('comment-box').llbox()<CR>", desc = "comment box" },
			{ "gB", "<cmd>lua require('comment-box').llbox()<CR>", mode = "v", desc = "comment box" },
		},
		opts = {},
	},
	{
		"danymat/neogen",
		enabled = true,
		cmd = "Neogen",
		keys = { { "gn", "<cmd>Neogen<cr>", desc = "Generate annotation" } },
		config = function()
			require("neogen").setup({
				enabled = true,
				snippet_engine = "luasnip",
				languages = {
					["cpp.doxygen"] = require("neogen.configurations.cpp"),
				},
			})
		end,
	},
}
