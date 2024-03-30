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
			{ "<leader>U", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
		},
	},

	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
		opts = { use_diagnostic_signs = true },
    		-- stylua: ignore
		keys = {
			{ '<leader>xx', function() require('trouble').toggle('document_diagnostics') end, desc = 'Document Diagnostics (Trouble)' },
			{ '<leader>e', function() require('trouble').toggle('workspace_diagnostics') end, desc = 'Workspace Diagnostics (Trouble)' },
			{ '<leader>xl', function() require('trouble').toggle('loclist') end, desc = 'Location List (Trouble)' },
			{ '<leader>xq', function() require('trouble').toggle('quickfix') end, desc = 'Quickfix List (Trouble)' },
			{
				'[q',
				function()
					if require('trouble').is_open() then
						require('trouble').previous({ skip_groups = true, jump = true })
					else
						vim.cmd.cprev()
					end
				end,
				desc = 'Previous trouble/quickfix item',
			},
			{
				']q',
				function()
					if require('trouble').is_open() then
						require('trouble').next({ skip_groups = true, jump = true })
					else
						vim.cmd.cnext()
					end
				end,
				desc = 'Next trouble/quickfix item',
			},
		},
	},

	-- Helper for removing buffers
	{
		"echasnovski/mini.bufremove",
		opts = {},
		-- stylua: ignore
		keys = {
			{ '<leader>bd', function() require('mini.bufremove').delete(0, false) end, desc = 'Delete Buffer', },
		},
	},

	-- Fancy window picker
	{
		"s1n7ax/nvim-window-picker",
		event = "VeryLazy",
		keys = function(_, keys)
			local pick_window = function()
				local picked_window_id = require("window-picker").pick_window()
				if picked_window_id ~= nil then
					vim.api.nvim_set_current_win(picked_window_id)
				end
			end

			local swap_window = function()
				local picked_window_id = require("window-picker").pick_window()
				if picked_window_id ~= nil then
					local current_winnr = vim.api.nvim_get_current_win()
					local current_bufnr = vim.api.nvim_get_current_buf()
					local other_bufnr = vim.api.nvim_win_get_buf(picked_window_id)
					vim.api.nvim_win_set_buf(current_winnr, other_bufnr)
					vim.api.nvim_win_set_buf(picked_window_id, current_bufnr)
				end
			end

			local mappings = {
				{ "sp", pick_window, desc = "Pick window" },
				{ "sw", swap_window, desc = "Swap picked window" },
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			hint = "floating-big-letter",
			show_prompt = false,
			filter_rules = {
				include_current_win = true,
				bo = {
					filetype = { "notify", "noice", "neo-tree-popup" },
					buftype = { "prompt", "nofile", "quickfix" },
				},
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
