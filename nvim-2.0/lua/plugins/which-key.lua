local go = require("config/global")
return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			delay = 400,
			spec = {
				{
					mode = { "n", "v" },
					-- Top-level groups
					{ "<leader>c", group = "Code" },
					{ "<leader>f", group = "Files" },
					{ "<leader>g", group = "Git" },
					{ "<leader>gh", group = "Git hunk" },
					{ "<leader>p", group = "Profile" },
					{ "<leader>q", group = "Quit" },
					{ "<leader>s", group = "Save" },
					{ "<leader>u", group = "UI" },
					{ "<leader>x", group = "Diagnostics" },
					{ "<leader>cw", group = "Workspace" },

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
			-- Buffer mappings
			{ "<leader>bc", "<cmd>bclose<cr>", desc = "Close Buffer" },
			{ "<leader>bn", "<cmd>enew<cr>", desc = "New Buffer" },
			{ "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
			{ "<leader>b?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps" },

			-- Quit mappings
			{ "<leader>qq", "<cmd>qa<cr>", desc = "Quit All" },
			{ "q", "<cmd>q<cr>", desc = "Quit" },

			-- Save mapping
			{ "<leader>s", "<Cmd>silent! update | redraw<CR>", desc = "Save" },

			-- Window mappings
			{ "<leader>wc", "<cmd>close<cr>", desc = "Close Window" },
			{ "<leader>ws", "<cmd>split<CR>", desc = "Split Horizontal" },
			{ "<leader>wv", "<cmd>vsplit<CR>", desc = "Split Vertical" },
			{ "<leader>wx", "<C-w>x<C-w>w", remap = true, desc = "Swap Windows" },
			{ "<leader>wh", "<C-w><C-h>", desc = "Window Left" },
			{ "<leader>wl", "<C-w><C-l>", desc = "Window Right" },
			{ "<leader>wj", "<C-w><C-j>", desc = "Window Down" },
			{ "<leader>wk", "<C-w><C-k>", desc = "Window Up" },
			{ "<c-w><space>", function() require("which-key").show({ keys = "<c-w>", loop = true }) end, desc = "Window Hydra" },

			-- Diagnostic mappings
			{ "<leader>xx", vim.diagnostic.open_float, desc = "Show Diagnostics" },
		},
	},
}
