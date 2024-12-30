return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				enabled = vim.fn.executable("make") == 1,
				build = "make",
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
		keys = {
			{
				"<leader><space>",
				"<cmd>Telescope find_files<cr>",
				desc = "Open file picker",
			},
			{
				"<C-p>",
				"<cmd>Telescope find_files<cr>",
				desc = "Open file picker",
			},
			{
				"<leader>,",
				"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
				desc = "Switch Buffer",
			},
			{
				"<leader>/",
				function()
					require("telescope.builtin").grep_string({
						shorten_path = true,
						word_match = "-w",
						only_sort_text = true,
						search = "",
					})
				end,
				desc = "Fuzzy Grep",
			},
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },

			-- Find
			{ "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{
				"<leader>fg",
				"<cmd>Telescope git_files<cr>",
				desc = "Find Files (git-files)",
			},
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			{
				"<leader>fc",
				function()
					require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Search Config files",
			},

			-- Searching
			{ '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
			{ "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
			{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
			{
				"<leader>sw",
				function()
					require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
				end,
				desc = "Word under cursor",
			},
			{
				"<leader>sw",
				function()
					require("telescope-live-grep-args.shortcuts").grep_visual_selection()
				end,
				mode = "v",
				desc = "Word visual selection",
			},
			{
				"<leader>sG", -- Example: '--no-ignore foo' or '-w exact-word'
				function()
					require("telescope").extensions.live_grep_args.live_grep_args({
						additional_args = function(args)
							return vim.list_extend(args, { "--hidden" })
						end,
					})
				end,
				desc = "Word in files",
			},
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{ "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
			{ "<leader>uc", "<cmd>Telescope colorscheme<cr>", desc = "Search Colorscheme" },
			-- -- Buffer.
			{
				"<leader>bg",
				function()
					require("telescope.builtin").live_grep({
						grep_open_files = true,
						prompt_title = "Grep live in Open Buffers",
					})
				end,
				desc = "[B]uffers [G]rep live",
			},

			-- Git
			{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Files" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commit repro" },
			{ "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Commit buffer" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branch" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
			telescope.load_extension("live_grep_args")
			require("telescope").setup({
				defaults = {
					-- open files in the first window that is an actual file.
					-- use the current window if no other window is available.
					get_selection_window = function()
						local wins = vim.api.nvim_list_wins()
						table.insert(wins, 1, vim.api.nvim_get_current_win())
						for _, win in ipairs(wins) do
							local buf = vim.api.nvim_win_get_buf(win)
							if vim.bo[buf].buftype == "" then
								return win
							end
						end
						return 0
					end,
					mappings = {
						i = {
							["<C-n>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-u>"] = false,
							["<C-d>"] = false,
							["<C-f>"] = actions.preview_scrolling_down,
							["<C-b>"] = actions.preview_scrolling_up,
							["jk"] = actions.close,
						},
						n = {
							q = actions.close,
							["jk"] = actions.close,
						},
					},
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
				pickers = {
					find_files = {
						find_command = function()
							return { "rg", "--files", "--color", "never", "-g", "!.git" }
							-- if 1 == vim.fn.executable("rg") then
							--    return { "rg", "--files", "--color", "never", "-g", "!.git" }
							-- elseif 1 == vim.fn.executable("fd") then
							--    return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
							-- elseif 1 == vim.fn.executable("fdfind") then
							--    return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
							-- elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
							--    return { "find", ".", "-type", "f" }
							-- elseif 1 == vim.fn.executable("where") then
							--    return { "where", "/r", ".", "*" }
							-- end
						end,
						hidden = true,
					},
				},
			})
		end,
	},
}
