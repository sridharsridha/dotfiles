return {
	{ -- Guess the indent and set appropriate values.
		"nmac427/guess-indent.nvim",
		lazy = false,
		priority = 50,
		config = true,
	},
	-- Search labels, enhanced character motions
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		opts = {},
		-- stylua: ignore
		keys = {
			{ 'ss', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
			{ 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
			{ 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
			{ 'R', mode = { 'x', 'o' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
			{ '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
		},
	},
	{
		"folke/todo-comments.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		-- stylua: ignore
		keys = {
			{ ']t', function() require('todo-comments').jump_next() end, desc = 'Next todo comment' },
			{ '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous todo comment' },
			{ '<leader>xt', '<cmd>TodoTrouble<CR>', desc = 'Todo (Trouble)' },
			{ '<leader>xT', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
			{ '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
			{ '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
		},
		opts = { signs = false },
	},

	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<Leader>gu", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
		},
	},
	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { use_diagnostic_signs = true },
    		-- stylua: ignore
		keys = {
			{ '<leader>xx', function() require('trouble').toggle('document_diagnostics') end, desc = 'Document Diagnostics (Trouble)' },
			{ '<leader>xX', function() require('trouble').toggle('workspace_diagnostics') end, desc = 'Workspace Diagnostics (Trouble)' },
			{ '<leader>xL', function() require('trouble').toggle('loclist') end, desc = 'Location List (Trouble)' },
			{ '<leader>xQ', function() require('trouble').toggle('quickfix') end, desc = 'Quickfix List (Trouble)' },
			{ 'gR', function() require('trouble').open('lsp_references') end, desc = 'LSP References (Trouble)' },
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

	-- Find the enemy and replace them with dark power
	{
		"nvim-pack/nvim-spectre",
		-- stylua: ignore
		keys = {
			{ '<Leader>sp', function() require('spectre').toggle() end, desc = 'Spectre', },
			{ '<Leader>sp', function() require('spectre').open_visual({ select_word = true }) end, mode = 'x', desc = 'Spectre Word' },
		},
		opts = {
			open_cmd = "noswapfile vnew",
			mapping = {
				["toggle_gitignore"] = {
					map = "tg",
					cmd = "<cmd>lua require('spectre').change_options('gitignore')<CR>",
					desc = "toggle gitignore",
				},
			},
			find_engine = {
				["rg"] = {
					cmd = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--ignore",
					},
					options = {
						["gitignore"] = {
							value = "--no-ignore",
							icon = "[G]",
							desc = "gitignore",
						},
					},
				},
			},
			default = {
				find = {
					cmd = "rg",
					options = { "ignore-case", "hidden", "gitignore" },
				},
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
	-- Pretty window for navigating LSP locations
	{
		"dnlhc/glance.nvim",
		cmd = "Glance",
		keys = {
			{ "gpd", "<cmd>Glance definitions<CR>" },
			{ "gpr", "<cmd>Glance references<CR>" },
			{ "gpy", "<cmd>Glance type_definitions<CR>" },
			{ "gpi", "<cmd>Glance implementations<CR>" },
		},
		opts = function()
			local actions = require("glance").actions
			return {
				folds = {
					fold_closed = "󰅂", -- 󰅂 
					fold_open = "󰅀", -- 󰅀 
					folded = true,
				},
				mappings = {
					list = {
						["<C-u>"] = actions.preview_scroll_win(5),
						["<C-d>"] = actions.preview_scroll_win(-5),
						["sg"] = actions.jump_vsplit,
						["sv"] = actions.jump_split,
						["st"] = actions.jump_tab,
						["p"] = actions.enter_win("preview"),
					},
					preview = {
						["q"] = actions.close,
						["p"] = actions.enter_win("list"),
					},
				},
			}
		end,
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
	-- Jump to the edge of block
	{
		"haya14busa/vim-edgemotion",
		-- stylua: ignore
		keys = {
			{ 'gj', '<Plug>(edgemotion-j)', mode = { 'n', 'x' }, desc = 'Move to bottom edge' },
			{ 'gk', '<Plug>(edgemotion-k)', mode = { 'n', 'x' }, desc = 'Move to top edge' },
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
