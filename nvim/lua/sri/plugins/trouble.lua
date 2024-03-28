return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		vim.keymap.set("n", "<leader>e", function()
			require("trouble").toggle("workspace_diagnostics")
		end, { desc = "Open diagnostic [E]rror messages" }),
		vim.keymap.set("n", "<leader>q", function()
			require("trouble").toggle("quickfix")
		end, { desc = "Open [Q]uickfix list" }),
	},
}
