return {
	{
		"mbbill/undotree",
      cmd = "UndotreeToggle",
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>ut", mode = { "n" }, "<cmd>UndotreeToggle<cr>", desc = "undoTree toggle" },
		},
	},
}
