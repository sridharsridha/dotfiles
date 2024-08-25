return {
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ [[<C-\>]], "<cmd>ToggleTerm<cr>", mode = { "i", "n" }, desc = "Terminal" },
			{ "<space>tm", "<cmd>TermExec cmd='a ws mk'<cr>", desc = "Workspace make" },
			{ "<space>tc", "<cmd>TermExec cmd='a ws mk check'<cr>", desc = "Workspace check" },
			{ "<space>tp", "<cmd>TermExec cmd='a ws mk product'<cr>", desc = "Workspace product" },
		},
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				direction = "float",
			})
		end,
	},
}
