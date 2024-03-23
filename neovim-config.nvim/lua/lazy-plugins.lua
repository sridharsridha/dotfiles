-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run
--    :Lazy
--  To update plugins, you can run
--    :Lazy update
require("lazy").setup({
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	-- Use `opts = {}` to force a plugin to be loaded.
	--  This is equivalent to:
	--    require('Comment').setup({})
	-- "gc" to comment visual regions/lines
	-- { "numToStr/Comment.nvim", opts = {} },

	require("sri/plugins/gitsigns"),
	require("sri/plugins/which-key"),
	require("sri/plugins/telescope"),
	require("sri/plugins/lspconfig"),
	require("sri/plugins/conform"),
	require("sri/plugins/cmp"),
	require("sri/plugins/tokyonight"),
	require("sri/plugins/todo-comments"),
	require("sri/plugins/mini"),
	require("sri/plugins/treesitter"),
	require("sri/plugins/whitespace"),
})
