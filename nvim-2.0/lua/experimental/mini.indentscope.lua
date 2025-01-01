return {
	{
		"echasnovski/mini.indentscope",
		enabled = false,
		event = "BufReadPre",
		opts = function(_, opts)
			opts.draw = {
				animation = require("mini.indentscope").gen_animation.none(),
			}
		end,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"lazy",
					"mason",
					"neo-tree",
					"Trouble",
					"lspinfo",
				},
				callback = function()
					vim.b["miniindentscope_disable"] = true
				end,
			})
		end,
	},
}
