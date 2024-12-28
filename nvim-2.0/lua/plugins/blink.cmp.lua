return {
	--- Completion menu stuffs
	{
		"saghen/blink.cmp",
		version = "*",
		event = { "InsertEnter", "LspAttach" },
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
		},
		opts = {
			keymap = { preset = "enter" },
			-- keymap = { preset = "default" },
			sources = {
				cmdline = { enabled = true },
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
	},
}
