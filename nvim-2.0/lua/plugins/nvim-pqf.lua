return {
	{
		"yorickpeterse/nvim-pqf",
		ft = "qf",
		event = "QuickFixCmdPost",
		config = function()
			require("pqf").setup({
				signs = {
					error = { text = "", hl = "DiagnosticSignError" },
					warning = { text = "", hl = "DiagnosticSignWarn" },
					info = { text = "", hl = "DiagnosticSignInfo" },
					hint = { text = "󰌵", hl = "DiagnosticSignHint" },
				},
			})
		end,
	},
}
