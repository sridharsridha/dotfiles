return {
	-- lua with lazy.nvim
	{
		"max397574/better-escape.nvim",
      lazy = false,
		config = function()
			require("better_escape").setup()
		end,
	},
}
