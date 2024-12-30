return {
	-- Helper for removing buffers
	{
		"echasnovski/mini.bufremove",
		opts = {},
		keys = {
			{
				"<leader>br",
				function()
					require("mini.bufremove").delete(0, false)
					vim.cmd.enew()
				end,
				desc = "Delete buffer and open new",
			},
		},
	},
}
