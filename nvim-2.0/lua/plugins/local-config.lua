local conf_path = vim.fn.stdpath("config") --[[@as string]]
return {
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
