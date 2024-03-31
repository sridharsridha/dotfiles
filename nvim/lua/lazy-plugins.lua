-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run
--    :Lazy
--  To update plugins, you can run
--    :Lazy update
require("lazy").setup({
	require("sri/plugins/which-key"),
	require("sri/plugins/editor"),
	require("sri/plugins/coding"),
	require("sri/plugins/git"),
	require("sri/plugins/fuzzy-finder"),
	require("sri/plugins/lspconfig"),
	require("sri/plugins/formatting"),
	require("sri/plugins/cmp"),
	require("sri/plugins/treesitter"),
	require("sri/plugins/ui"),

	-- Custom plugin directory
	{ dir = "~/arista.nvim", lazy = false },

	-- Themes
	require("sri/plugins/colorscheme"),
})

-- Configure key lazy.nvim bindings
local K = vim.keymap.set
K("n", "<leader>ph", require("lazy").home, { desc = "Plugins Home" })
K("n", "<leader>pi", require("lazy").install, { desc = "Plugins Install" })
K("n", "<leader>pS", require("lazy").sync, { desc = "Plugins Sync" })
K("n", "<leader>pu", require("lazy").check, { desc = "Plugins Check Updates" })
K("n", "<leader>pU", require("lazy").update, { desc = "Plugins Update" })
K("n", "<leader>pl", require("lazy").update, { desc = "Plugins Log" })
