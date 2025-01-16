return {
	{
		"mbbill/undotree",
      cmd = "UndotreeToggle",
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>ut", mode = { "n" }, "<cmd>UndotreeToggle<cr>", desc = "undoTree toggle" },
		},
	},
}
