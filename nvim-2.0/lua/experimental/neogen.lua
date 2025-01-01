return {
	{
		"danymat/neogen",
		enabled = false,
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
