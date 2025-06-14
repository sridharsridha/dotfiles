local go = require("config/global")
return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			notify = true,

			delay = 400,
			spec = {
				{
					mode = { "n", "v" },
					-- Top-level groups
					{ "<leader>c", group = "Code" },
					{ "<leader>f", group = "Files" },
					{ "<leader>g", group = "Git" },
					{ "<leader>gd", group = "Git diff" },
					{ "<leader>gh", group = "Git hunk" },
					{ "<leader>p", group = "Profile" },
					{ "<leader>t", group = "Terminal" },
					{ "<leader>q", group = "Quit" },
					{ "<leader>s", group = "Save" },
					{ "<leader>u", group = "UI tools" },
					{ "<leader>x", group = "Diagnostics" },
					{ "<leader>cw", group = "code workspace" },

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
			show_help = true,
			show_keys = true,
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				presets = {
					operators = true, -- adds help for operators like d, y, ...
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
		},
		keys = {
			-- Buffer mappings
			{ "<leader>bc", "<cmd>bclose<cr>", desc = "Close Buffer" },
			{ "<leader>bn", "<cmd>enew<cr>", desc = "New Buffer" },
			{ "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
			{
				"<leader>b?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps",
			},

			-- Quit mappings
			{ "<leader>q", "<cmd>qa!<cr>", desc = "Quit All" },
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
			{
				"<c-w><space>",
				function()
					require("which-key").show({ keys = "<c-w>", loop = true })
				end,
				desc = "Window Hydra",
			},

			-- Diagnostic mappings
			{ "<leader>xs", vim.diagnostic.open_float, desc = "Show Diagnostics" },
		},
	},
}
