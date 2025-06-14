return {
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ [[<C-\>]], "<cmd>ToggleTerm<cr>", mode = { "i", "n" }, desc = "Terminal" },
			{ "<leader>tt", "<cmd>ToggleTerm<cr>", mode = { "i", "n" }, desc = "Terminal" },
			{ "<leader>tm", "<cmd>TermExec cmd='a ws mk'<cr>", desc = "Workspace make" },
			{ "<leader>tc", "<cmd>TermExec cmd='a ws mk check'<cr>", desc = "Workspace check" },
			{ "<leader>tp", "<cmd>TermExec cmd='a ws mk product'<cr>", desc = "Workspace product" },
		},
		config = function()
			require("toggleterm").setup({
				open_mapping = {[[<c-\>]], "<leader>tt"},
				direction = "float",
			})
		end,
	},
}
