return {
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"saghen/blink.cmp",
		},
		build = ":Codeium Auth",
		config = function()
			require("codeium").setup({})
		end,
	},
}
