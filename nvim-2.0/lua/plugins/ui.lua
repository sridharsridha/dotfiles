return {
	{ "echasnovski/mini.tabline",
      lazy = true,
      event = "BufReadPre",
      opts = {
         show_icons = false
      },
      enabled = true
   },
	{ "echasnovski/mini.statusline",
      lazy = true,
      event = "BufReadPre",
      opts = { use_icons = false }, enabled = true },
	{ "echasnovski/mini.indentscope",
      lazy = true,
		enabled = true,
		event = "BufReadPre",
		opts = function(_, opts)
			opts.draw = {
				animation = require("mini.indentscope").gen_animation.none(),
			}
		end,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"alpha",
					"dashboard",
					"help",
					"lazy",
					"lazyterm",
					"man",
					"mason",
					"neo-tree",
					"notify",
					"Outline",
					"toggleterm",
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
