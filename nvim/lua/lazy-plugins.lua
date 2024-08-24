require("lazy").setup({

	-- List of all plugins and thier configurations
	require("sri/plugins/which-key"),
	require("sri/plugins/toggleterm"),
	require("sri/plugins/coding"),
	require("sri/plugins/comment"),
	require("sri/plugins/mini-ai"),
	require("sri/plugins/git"),
	require("sri/plugins/fuzzy-finder"),
	require("sri/plugins/lspconfig"),
	require("sri/plugins/formatting"),
	require("sri/plugins/cmp"),
	require("sri/plugins/treesitter"),
	require("sri/plugins/ui"),

	-- Tmux integration.
	{ "aserowy/tmux.nvim", opts = {} },
	-- Custom plugin directory
	{ dir = "~/arista.nvim", lazy = false },
	-- Themes
	require("sri/plugins/colorscheme"),
}, {
	ui = {
		icons = {},
		custom_keys = {},
	},
})

-- Configure key lazy.nvim bindings
local K = vim.keymap.set
K("n", "<leader>ph", require("lazy").home, { desc = "Plugins Home" })
K("n", "<leader>pi", require("lazy").install, { desc = "Plugins Install" })
K("n", "<leader>pS", require("lazy").sync, { desc = "Plugins Sync" })
K("n", "<leader>pu", require("lazy").check, { desc = "Plugins Check Updates" })
K("n", "<leader>pU", require("lazy").update, { desc = "Plugins Update" })
K("n", "<leader>pl", require("lazy").update, { desc = "Plugins Log" })
