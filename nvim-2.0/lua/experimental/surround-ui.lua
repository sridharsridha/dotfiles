return {
	{
		"roobert/surround-ui.nvim",
      event = "InsertEnter",
		dependencies = {
			"kylechui/nvim-surround",
			"folke/which-key.nvim",
		},
		config = function()
			require("surround-ui").setup({
				root_key = "s",
			})
		end,
	},
}
