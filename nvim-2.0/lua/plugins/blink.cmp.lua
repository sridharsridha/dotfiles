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
			-- Experimental signature help support
			signature = { enabled = true },
			sources = {
				cmdline = { enabled = true },
				default = { "lsp", "path", "snippets", "buffer" },
			},
			completion = {
				-- Show documentation when selecting a completion item
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
				-- Display a preview of the selected item on the current line
				ghost_text = { enabled = true },
				menu = {
					-- nvim-cmp style menu
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
						},
					},
				},
			},
		},
	},
}
