return {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	config = function()
		require("lsp_signature").setup({
			bind = true,
			handler_opts = {
				border = "rounded",
			},
			floating_window = true,
			floating_window_above_cur_line = true,
			hint_enable = true,
			-- highlight group used to highlight the current parameter
			hi_parameter = "LspSignatureActiveParameter",
			-- toggle signature on and off in insert mode
			toggle_key = "<M-x>",
		})
	end,
}
