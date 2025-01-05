local go = require("config/global")
return {
	{
		"saghen/blink.cmp",
		version = "*",
		event = { "InsertEnter" },
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
		},
		opts = {
			keymap = { preset = "default" },
			appearance = {
				use_nvim_cmp_as_default = false,
			},
			signature = { enabled = true, window = { border = go.border } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {},
				cmdline = function()
					local type = vim.fn.getcmdtype()
					if type == "/" or type == "?" then
						return { "buffer" }
					end
					if type == ":" then
						return { "cmdline" }
					end
					return {}
				end,
			},

			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				ghost_text = { enabled = true },
				list = {
					selection = "auto_insert",
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = go.border,
					},
				},
				menu = {
					border = go.border,
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
						},
						components = {
							item_idx = {
								text = function(ctx)
									return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
								end,
								highlight = "comment",
							},
							seperator = {
								text = function()
									return "│"
								end,
								highlight = "comment",
							},
						},
						gap = 1,
						treesitter = { "lsp" },
					},
				},
			},
		},
	},
}
