return {
	{
		"catppuccin/nvim",
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
				cmp = true,
				treesitter = true,
				mason = true,
				fidget = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},
		},
		-- config = function()
		-- 	require("catppuccin").setup({
		-- 		flavour = "mocha", -- latte, frappe, macchiato, mocha
		-- 		integrations = {
		-- 			treesitter = true,
		-- 			mini = {
		-- 				enabled = true,
		-- 			},
		-- 			diffview = true,
		-- 			fidget = true,
		-- 			mason = true,
		-- 			which_key = true,
		-- 			-- telescope = {
		-- 			-- 	enabled = true,
		-- 			-- 	style = "nvchad",
		-- 			-- },
		-- 			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		-- 		},
		-- 	})
		-- end,
	},
}
