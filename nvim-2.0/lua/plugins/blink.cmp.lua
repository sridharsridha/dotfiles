local go = require("config/global")
return {
	{
		"saghen/blink.cmp",
		event = { "InsertEnter" },
		-- Needed to download pre-build binary for fuzzy finding.
		version = "1.*",
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
		},
		opts = {
			keymap = {
				preset = "default",
				["<C-y>"] = { "select_and_accept", "fallback" },
				["<c-e>"] = { "hide", "fallback" },
				["<tab>"] = { "snippet_forward", "fallback" },
				["<s-tab>"] = { "snippet_backward", "fallback" },
				["<c-b>"] = { "scroll_documentation_up", "fallback" },
				["<c-f>"] = { "scroll_documentation_down", "fallback" },
				["<c-s>"] = { "show_signature", "hide_signature", "fallback" },
			},
			signature = {
				enabled = true,
				window = {
					border = "none", -- Set this to false to remove the border
				},
			},
			completion = {
				ghost_text = { enabled = true },
				list = {
					selection = { preselect = true, auto_insert = true },
				},
				menu = {
					scrollbar = false,
				},
			},
		},
	},
}
