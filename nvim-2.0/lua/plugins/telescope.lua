return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
			{ "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
			{ "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Autocommands" },
			{
				"<leader>f/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "Find in Current Buffer",
			},
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
			{
				"<leader>f.",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fn.stdpath("config"),
					})
				end,
				desc = "Find in Dotfiles",
			},
			{
				"<leader>f*",
				function()
					require("telescope.builtin").grep_string({
						search = vim.fn.expand("<cword>"),
					})
				end,
				desc = "Grep for Word Under Cursor",
			},
			{
				"<leader>fo",
				function()
					local alternates = require("utils.alternate").get_alternate_files()
					if #alternates > 0 then
						require("telescope.pickers")
							.new({}, {
								prompt_title = "Alternate Files",
								finder = require("telescope.finders").new_table({
									results = alternates,
								}),
								sorter = require("telescope.config").values.generic_sorter({}),
							})
							:find()
					else
						vim.notify("No alternate files found", vim.log.levels.INFO)
					end
				end,
				desc = "Find Alternate Files",
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
						},
						n = {
							["q"] = actions.close,
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			telescope.load_extension("fzf")
		end,
	},
}
