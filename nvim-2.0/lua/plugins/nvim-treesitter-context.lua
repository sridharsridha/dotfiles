return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost" },
		config = function()
			require("treesitter-context").setup({
				mode = "cursor",
				max_lines = require("config/global").is_remote and 2 or 5,
			})
		end,
	},
}
