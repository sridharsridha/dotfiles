local conf_path = vim.fn.stdpath("config") --[[@as string]]
return {
	{
		dir = "~/vim-plugins/arista.nvim",
		lazy = false,
		enabled = function()
			return (vim.uv or vim.loop).fs_stat(vim.fn.expand("$HOME/vim-plugins/arista.nvim"))
		end,
	},
	{
		name = "options",
		event = "VeryLazy",
		dir = conf_path,
		config = function()
			require("config/options").final()
			require("config/mappings").final()
			require("config/autocmds").final()
		end,
	},
}
