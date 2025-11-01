-- ╭─────────────────────────────────────────────────────────╮
-- │ Telescope - Fuzzy Finder and Picker                     │
-- │ Highly extensible fuzzy finder over lists               │
-- ╰─────────────────────────────────────────────────────────╯

return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope", -- Lazy load on command
		dependencies = {
			{ "nvim-lua/plenary.nvim" },                         -- Required dependency
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Native FZF sorter (faster)
		},
		-- ────────────────────────────────────────────────────
		-- Key Mappings
		-- ────────────────────────────────────────────────────
		keys = {
			-- File Navigation
			{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" }, -- Custom: Quick file access
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },

			-- Help & Documentation
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
			{ "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Autocommands" },

			-- Diagnostics & Lists
			{ "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			-- Search & Navigation
			{
				"<leader>f/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "Find in Current Buffer",
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

			-- Git Integration
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },

			-- Custom Functions
			{
				"<leader>f.",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fn.stdpath("config"), -- Search in Neovim config directory
					})
				end,
				desc = "Find in Dotfiles",
			},
			{
				"<leader>fo",
				function()
					-- Custom: Find alternate files (e.g., header/source pairs)
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
		-- ────────────────────────────────────────────────────
		-- Configuration
		-- ────────────────────────────────────────────────────
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					-- Custom key mappings within Telescope
					mappings = {
						i = {
							["<C-u>"] = false, -- Disable default scroll up
							["<C-j>"] = "move_selection_next", -- Custom: vim-like navigation
							["<C-k>"] = "move_selection_previous", -- Custom: vim-like navigation
						},
						n = {
							["q"] = actions.close, -- Custom: Quick exit with q
						},
					},
				},
				extensions = {
					-- FZF extension for better performance
					fzf = {
						fuzzy = true,                      -- Enable fuzzy matching
						override_generic_sorter = true,    -- Override default sorter
						override_file_sorter = true,       -- Override file sorter
						case_mode = "smart_case",          -- Smart case sensitivity
					},
				},
			})

			-- Load FZF extension for faster sorting
			telescope.load_extension("fzf")
		end,
	},
}
