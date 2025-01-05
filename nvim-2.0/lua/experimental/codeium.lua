return {
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = ":Codeium Auth",
		config = function()
			require("codeium").setup({})
		end,
	},
}
