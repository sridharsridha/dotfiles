return {
	{ "MTDL9/vim-log-highlighting" },
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		dependencies = {
			-- Textobjects using treesitter queries
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
		},
		config = function()
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"lua",
					"markdown",
					"vim",
					"vimdoc",
					"python",
					"json",
					"yaml",
					"tmux",
					"cpp",
				},
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				-- refactor = {
				-- 	highlight_definitions = { enable = true },
				-- 	highlight_current_scope = { enable = true },
				-- },
				-- -- See: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["a,"] = "@parameter.outer",
							["i,"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["],"] = "@parameter.inner",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[,"] = "@parameter.inner",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = { [">,"] = "@parameter.inner" },
						swap_previous = { ["<,"] = "@parameter.inner" },
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufRead" },
		config = function()
			require("treesitter-context").setup({
				mode = "cursor",
				max_lines = 3,
			})
		end,
	},
}
