return {
	{
		"echasnovski/mini.bufremove",
		keys = {
			{ "<leader>bd", "<cmd>lua MiniBufremove.delete()<cr>", mode = "n", desc = "Delete Buffer" },
			{ "<leader>bw", "<cmd>lua MiniBufremove.wipeout()<cr>", mode = "n", desc = "Wipeout Buffer" },
		},
		opts = {},
	},
}
