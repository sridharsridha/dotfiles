return {
	{
		"saghen/blink.cmp",
		version = "*",
		event = { "InsertEnter" },
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{ "Exafunction/codeium.nvim" },
			-- add blink.compat
			{
				"saghen/blink.compat",
				-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
				version = "*",
				-- make sure to set opts so that lazy.nvim calls blink.compat's setup
				opts = {},
			},
		},
		opts = {
			keymap = { preset = "default" },
			appearance = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = false,
				-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
				kind_icons = {
					Text = "󰉿",
					Method = "",
					Function = "󰊕",
					Constructor = "󰒓",

					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "󱡠",
					Interface = "󱡠",
					Struct = "󱡠",
					Module = "󰅩",

					Unit = "󰪚",
					Value = "󰦨",
					Enum = "󰦨",
					EnumMember = "󰦨",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "󱄽",
					Color = "󰏘",
					File = "󰈔",
					Reference = "󰬲",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "󰪚",
					TypeParameter = "󰬛",
					Error = "󰏭",
					Warning = "󰏯",
					Information = "󰏮",
					Hint = "󰏭",
				},
			},
			signature = { enabled = true, window = { border = "rounded" } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "codeium" },
				providers = {
					codeium = {
						name = "codeium",
						module = "blink.compat.source",
					},
				},
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
					-- experimental auto-brackets support
					auto_brackets = {
						enabled = true,
					},
				},
				ghost_text = { enabled = true },
				list = {
					-- selection = "manual",
					selection = "auto_insert",
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = "rounded",
					},
				},
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "kind_icon" },
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
