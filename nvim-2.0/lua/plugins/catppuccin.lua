-- ╭─────────────────────────────────────────────────────────╮
-- │ Catppuccin Colorscheme                                  │
-- │ Soothing pastel theme with dark mocha variant           │
-- ╰─────────────────────────────────────────────────────────╯

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,     -- Load colorscheme early
		lazy = false,        -- Load immediately on startup
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- Dark variant (custom preference)
				transparent_background = true, -- Terminal transparency support (custom)
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
