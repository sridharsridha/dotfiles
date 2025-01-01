return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treeitter** module to be loaded in time.
			-- Luckily, the only thins that those plugins need are the custom queries, which we make available
			-- during startup.
			-- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
			-- require("lazy.core.loader").add_to_rtp(plugin)
			-- require("nvim-treesitter.query_predicates")
		end,
		config = function()
			-- Custom filetype treesitter.
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.tac = {
				install_info = {
					url = "~/tree-sitter-tac",
					files = { "src/scanner.cc", "src/parser.c" },
					generate_requires_npm = false, -- if stand-alone parser without npm dependencies
					requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
				},
				filetype = "tac",
			}

			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				refactor = {
					highlight_definitions = { enable = true },
					highlight_current_scope = { enable = true },
				},
				matchup = {
					enable = true,
				},
				ignore_install = {},
				ensure_installed = {},
				sync_install = false,
				modules = {},
			})
			vim.treesitter.language.register("markdown", "mdx")
		end,
	},
}
