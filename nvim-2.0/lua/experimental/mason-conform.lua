return {
	{
		"zapling/mason-conform.nvim",
		enabled = false,
		event = "BufReadPre",
		config = true,
		dependencies = {
			"williamboman/mason.nvim",
			"stevearc/conform.nvim",
		},
	},
}
