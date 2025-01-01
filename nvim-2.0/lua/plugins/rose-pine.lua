return {
	"rose-pine/neovim",
	lazy = false,
	name = "rose-pine",
	priority = 1000,
	opt = {
		dark_variant = "main", -- main, moon, or dawn
		dim_inactive_windows = false,
		extend_background_behind_borders = true,
		enable = {
			terminal = true,
		},
		styles = {
			bold = true,
			italic = true,
			transparency = true,
		},
		highlight_groups = {
			["@statement"] = { link = "Statement" },
			["@structure"] = { link = "Structure" },
		},
	},
	config = function()
		vim.cmd("colorscheme rose-pine")
	end,
}
