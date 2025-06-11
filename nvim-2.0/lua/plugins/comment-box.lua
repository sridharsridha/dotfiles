return {
	-- Type :CB and get completion, use CBllbox 10
	{
		"LudoPinelli/comment-box.nvim",
		event = "InsertEnter",
		keys = {
			{ "gB", "<cmd>lua require('comment-box').llbox()<CR>", desc = "comment box" },
			{ "gB", "<cmd>lua require('comment-box').llbox()<CR>", mode = "v", desc = "comment box" },
		},
		opts = {},
	},
}
