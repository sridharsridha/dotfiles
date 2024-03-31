return {
	{ -- Guess the indent and set appropriate values.
		"nmac427/guess-indent.nvim",
		lazy = false,
		priority = 50,
		config = true,
	},

	{
		"folke/todo-comments.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<leader>tu", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
		},
	},

	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{
				"<leader>de",
				function()
					require("trouble").toggle("document_diagnostics")
				end,
				desc = "Document Diagnostics (Trouble)",
			},
			{
				"<leader>we",
				function()
					require("trouble").toggle("workspace_diagnostics")
				end,
				desc = "Workspace Diagnostics (Trouble)",
			},
			{
				"<leader>tl",
				function()
					require("trouble").toggle("loclist")
				end,
				desc = "Location List (Trouble)",
			},
			{
				"<leader>tq",
				function()
					require("trouble").toggle("quickfix")
				end,
				desc = "Quickfix List (Trouble)",
			},
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").previous({ skip_groups = true, jump = true })
					else
						vim.cmd.cprev()
					end
				end,
				desc = "Previous trouble/quickfix item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						vim.cmd.cnext()
					end
				end,
				desc = "Next trouble/quickfix item",
			},
		},
	},

	-- Helper for removing buffers
	{
		"echasnovski/mini.bufremove",
		opts = {},
		keys = {
			{
				"sr",
				function()
					require("mini.bufremove").delete(0, false)
					vim.cmd.enew()
				end,
				desc = "Delete buffer and open new",
			},
		},
	},

	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ [[<C-\>]], "<cmd>ToggleTerm<cr>", desc = "Terminal" },
		},
		cmd = { "ToggleTerm", "TermExec" },
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
			})
		end,
	},
	{
		"aserowy/tmux.nvim",
		opts = {},
	},
}
