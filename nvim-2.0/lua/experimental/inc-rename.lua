return {
	{
		"smjonas/inc-rename.nvim",
		enabled = false,
		cmd = "IncRename",
		opts = {},
		keys = {
			{
				"<leader>cr",
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				expr = true,
				desc = "rename",
			},
		},
	},
}
