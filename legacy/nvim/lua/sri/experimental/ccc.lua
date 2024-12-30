return {

	-- Super powerful color picker/colorizer plugin
	{
		"uga-rosa/ccc.nvim",
		ft = { "tmux", "markdown", "lua" },
		keys = {
			{ "<Leader>mc", "<cmd>CccPick<CR>", desc = "Color-picker" },
		},
		opts = {
			highlighter = {
				auto_enable = true,
				lsp = true,
				excludes = { "lazy", "mason", "help", "neo-tree" },
			},
		},
	},
}
