return {
	{
		"yorickpeterse/nvim-pqf",
		ft = "qf",
		event = "QuickFixCmdPost",
		config = function()
			require("pqf").setup({
				signs = {
					error = { text = "E", hl = "DiagnosticSignError" },
					warning = { text = "W", hl = "DiagnosticSignWarn" },
					info = { text = "I", hl = "DiagnosticSignInfo" },
					hint = { text = "H", hl = "DiagnosticSignHint" },
				},
			})
		end,
	},
}
