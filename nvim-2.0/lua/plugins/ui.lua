return {
	{ "echasnovski/mini.tabline",
      opts = {
         show_icons = false
      },
   },

	{ "echasnovski/mini.statusline",
      opts = { use_icons = false 
      },
   },

	{ "echasnovski/mini.indentscope",
      lazy = true,
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

   { "nvim-tree/nvim-web-devicons", lazy = true },

   -- Tmux integration.
   {
      "aserowy/tmux.nvim",
      opts = {
         copy_sync = {
            -- redirect_to_clipboard = true,
            enable = false,
         },
      },
   }, 
}
