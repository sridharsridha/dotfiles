return {
	{ -- Put cursor at last place
		"ethanholz/nvim-lastplace",
		lazy = false,
		config = function()
			require("nvim-lastplace").setup({})
		end,
	},
}
