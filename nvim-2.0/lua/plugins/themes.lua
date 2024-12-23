return {
	{ "ellisonleao/gruvbox.nvim", enabled = false },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				integrations = {
					nvimtree = true,
					treesitter = true,
					mini = {
						enabled = true,
					},
					diffview = true,
					fidget = true,
					mason = true,
					which_key = true,
					telescope = {
						enabled = true,
						style = "nvchad",
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
