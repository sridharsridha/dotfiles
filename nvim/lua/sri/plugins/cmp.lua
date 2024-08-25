return {
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"dmitmel/cmp-cmdline-history",
			"andersevenrud/cmp-tmux",
			"hrsh7th/cmp-buffer",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local neogen = require("neogen")

			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({
				region_check_events = "CursorMoved",
				delete_check_events = "TextChanged",
			})

			cmp.setup({
				ghost_text = { enabled = true },
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
				}, { -- group 2 only if nothing in above had results
					{ name = "buffer" },
					{ name = "path" },
					{ name = "tmux" },
				}),

				mapping = cmp.mapping.preset.insert({
					["<Esc>"] = cmp.mapping.close(),
					["<C-j>"] = cmp.mapping(
						cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
						{ "i", "s", "c" }
					),
					["<C-k>"] = cmp.mapping(
						cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
						{ "i", "s", "c" }
					),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<c-e>"] = cmp.mapping.abort(),
					["<cr>"] = cmp.mapping.confirm({ select = true }),
					["<C-l>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						elseif neogen.jumpable() then
							neogen.jump_next()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function(fallback)
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						elseif neogen.jumpable(-1) then
							neogen.jump_prev()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
			})
			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					-- { name = "buffer" },
					{ name = "cmdline_history" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path" },
					{ name = "cmdline" },
					{ name = "cmdline_history" },
				},
			})
			vim.cmd([[
			           highlight! link CmpItemMenu Comment
			           " gray
			           highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
			           " blue
			           " highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
			           " highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
			           "" light blue
			           "highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
			           "highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
			           "highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
			           " " pink
			           " highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
			           " highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
			           " front
			           highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
			           highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
			           highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
			         ]])
		end,
	},
}
