return {
	{
		"rshkarin/mason-nvim-lint",
		enabled = false,
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			quiet_mode = true,
		},
	},
}
