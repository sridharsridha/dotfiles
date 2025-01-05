local go = require("config/global")
return {
	-- Useful plugin to show you pending keybinds.
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts_extend = { "spec" },
		opts = {
			preset = "helix",
			delay = 400,
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader>c", group = "Code" },
					{ "<leader>co", group = "Alternate files" },
					{ "<leader>f", group = "Files" },
					{ "<leader>g", group = "Git" },
					{ "<leader>u", group = "UI" },
					{ "<leader>p", group = "Profile" },
					{ "<leader>x", group = "Diagnostics" },
					{ "<leader>q", group = "Quit" },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
					{
						"<leader>b",
						group = "Buffer",
						expand = function()
							return require("which-key.extras").expand.buf()
						end,
					},
					{
						"<leader>w",
						group = "Windows",
						proxy = "<c-w>",
						expand = function()
							return require("which-key.extras").expand.win()
						end,
					},
				},
			},
			show_help = false,
			win = {
				border = go.border,
			},
			icons = {
				separator = go.icons.seperator,
				mappings = go.use_icons,
			},
		},
		keys = {
			{
				"<leader>b?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			},
			{
				"<c-w><space>",
				function()
					require("which-key").show({ keys = "<c-w>", loop = true })
				end,
				desc = "Window Hydra Mode (which-key)",
			},
		},
	},
}
