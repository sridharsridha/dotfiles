-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run
--    :Lazy
--  To update plugins, you can run
--    :Lazy update
require("lazy").setup({
	require("sri/plugins/which-key"),
	require("sri/plugins/editor"),
	require("sri/plugins/coding"),
	require("sri/plugins/gitsigns"),
	require("sri/plugins/telescope"),
	require("sri/plugins/lspconfig"),
	require("sri/plugins/formatting"),
	require("sri/plugins/cmp"),
	require("sri/plugins/mini"),
	require("sri/plugins/treesitter"),
	require("sri/plugins/ui"),

	-- Custom plugin directory
	{ dir = "~/arista.nvim", lazy = false },

	-- Themes
	require("sri/plugins/colorscheme"),
})
