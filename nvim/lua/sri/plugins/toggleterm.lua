return {
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ [[<space>tt]], "<cmd>ToggleTerm<cr>", desc = "Terminal" },
			{ [[<space>tm]], "<cmd>TermExec cmd='a ws mk'<cr>", desc = "Workspace make" },
			{ [[<space>tc]], "<cmd>TermExec cmd='a ws mk check'<cr>", desc = "Workspace check" },
			{ [[<space>tp]], "<cmd>TermExec cmd='a ws mk product'<cr>", desc = "Workspace product" },
		},
		cmd = { "ToggleTerm", "TermExec" },
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<sapce>tt]],
				direction = "float",
			})
		end,
	},
}
