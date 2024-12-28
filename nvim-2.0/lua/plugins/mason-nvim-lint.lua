return {
	{
		"rshkarin/mason-nvim-lint",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			quiet_mode = true,
		},
	},
}
