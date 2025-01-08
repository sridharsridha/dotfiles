return {
	{
		"catppuccin/nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		init = function()
			vim.cmd.colorscheme("catppuccin")
		end,
		opts = {
			transparent_background = true,
			compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
			compile = true,
			flavour = "mocha",
			integrations = {
				snacks = true,
				blink_cmp = true,
				treesitter = true,
				mason = true,
				fidget = true,
				which_key = true,
				flash = true,
				fzf = true,
				gitsigns = true,
				grug_far = true,
				neotree = true,
				lsp_trouble = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				-- For more plugins integrations please scroll down
				-- (https://github.com/catppuccin/nvim#integrations)
			},
		},
	},
}
