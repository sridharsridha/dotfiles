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
			signature = { enabled = true, window = { border = go.border } },
			completion = {
				ghost_text = { enabled = true },
				list = {
               selection = { preselect = true, auto_insert = true }
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = go.border,
					},
				},
				menu = {
               scrollbar = false,
					border = go.border,
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
