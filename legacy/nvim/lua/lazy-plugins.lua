require("lazy").setup({

	-- List of all plugins and thier configurations
	require("sri/plugins/which-key"),
	require("sri/plugins/terminal"),
	require("sri/plugins/coding"),
	require("sri/plugins/comment"),
	require("sri/plugins/git"),
	require("sri/plugins/fuzzy-finder"),
	require("sri/plugins/lspconfig"),
	require("sri/plugins/formatting"),
	require("sri/plugins/linting"),
	require("sri/plugins/cmp"),
	require("sri/plugins/treesitter"),
	require("sri/plugins/ui"),
	require("sri/plugins/colorscheme"),
	-- Custom plugin directory
	{
		dir = "~/vim-plugins/arista.nvim",
		lazy = false,
		enabled = function()
			return (vim.uv or vim.loop).fs_stat("~/vim-plugins/arista.nvim")
		end,
	},
	-- { dir = "~/vim-plugins/mts.nvim", lazy = false, enabled = false },
	-- { dir = "~/vim-plugins/bug.nvim", lazy = false, enabled = false },
})
