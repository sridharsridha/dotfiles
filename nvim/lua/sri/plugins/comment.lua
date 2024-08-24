return {
	{
		-- Fast and familiar per-line commenting
		"echasnovski/mini.comment",
		event = { "InsertEnter" },
		opts = {
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Toggle comment (like `gcip` - comment inner paragraph) for both
				-- Normal and Visual modes
				comment = "gc",

				-- Toggle comment on current line
				comment_line = "gcc",

				-- Toggle comment on visual selection
				comment_visual = "gc",

				-- Define 'comment' textobject (like `dgc` - delete whole comment block)
				-- Works also in Visual mode if mapping differs from `comment_visual`
				textobject = "gc",
			},
		},
	},
	{
		"s1n7ax/nvim-comment-frame",
		event = "InsertEnter",
		requires = {
			{ "nvim-treesitter" },
		},
		config = function()
			require("nvim-comment-frame").setup({
				keymap = "gCf",
				multiline_keymap = "gCF",
			})
		end,
	},
	{
		"LudoPinelli/comment-box.nvim",
		event = "InsertEnter",
		keys = {
			{ "gCb", "<cmd>lua require('comment-box').llbox()<CR>", desc = "comment box" },
			{ "gCb", "<cmd>lua require('comment-box').llbox()<CR>", mode = "v", desc = "comment box" },
		},
		opts = {},
	},
	{
		"danymat/neogen",
		event = "InsertEnter",
		keys = { "gCg", "<cmd>lua require('neogen').generate()<cr>", desc = "Generate annotation" },
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
