return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				enabled = vim.fn.executable("make") == 1,
				build = "make",
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "rcarriga/nvim-notify" },
		},
		cmd = "Telescope",
		init = function()
			vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Open file picker" })
			vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Open file picker" })
		end,
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			telescope.setup({
				defaults = {
					file_ignore_patterns = { "\\.git/", "node_modules/", ".venv/" },
					mappings = {
						i = {
							["<C-n>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-u>"] = false,
							["<C-d>"] = false,
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
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
					live_grep_args = {
						auto_quoting = true, -- If the prompt value does not begin with ', " or - the entire prompt is treated as a single argument
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("notify")

			local map = vim.keymap.set
			-- Searching.
			map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			map("n", "<leader>f", builtin.find_files, { desc = "[S]earch [F]iles" })
			map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			map("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
			map("n", "<leader>sl", builtin.current_buffer_fuzzy_find, { desc = "[S]earch [L]ines" })
			map("n", "<leader>sc", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch neovim [C]onfig files" })
			map("n", "<leader>s'", require("telescope.builtin").marks, { desc = "[S]earch [M]arks" })
			map("n", "<leader>sn", function()
				require("telescope").extensions.notify.notify()
			end, { desc = "[S]earch [N]otifications" })
			map("n", "<leader>s*", function()
				require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
			end, { desc = "[S]earch word under cursor" })
			map("v", "<leader>s*", function()
				require("telescope-live-grep-args.shortcuts").grep_visual_selection()
			end, { desc = "[S]earch text from selection" })
			map(
				"n",
				"<leader>sw", -- Example: '--no-ignore foo' or '-w exact-word'
				function()
					require("telescope").extensions.live_grep_args.live_grep_args({
						additional_args = function(args)
							return vim.list_extend(args, { "--hidden" })
						end,
					})
				end,
				{ desc = "[S]earch [W]ord in files" }
			)
			map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch [G]rep live" })
			-- -- Buffer.
			map("n", "<leader>bg", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Grep live in Open Buffers",
				})
			end, { desc = "[B]uffers [G]rep live" })

			-- Git.
			map("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "[G]it [F]iles" })
			map("n", "<leader>gs", require("telescope.builtin").git_status, { desc = "[G]it [S]tatus" })
			map("n", "<leader>gc", require("telescope.builtin").git_commits, { desc = "[G]it [C]ommit repro" })
			map("n", "<leader>gC", require("telescope.builtin").git_bcommits, { desc = "[G]it [C]ommit buffer" })
			map("n", "<leader>gb", require("telescope.builtin").git_branches, { desc = "[G]it [B]ranch" })
		end,
	},
}
