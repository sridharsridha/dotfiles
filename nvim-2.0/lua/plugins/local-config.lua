local conf_path = vim.fn.stdpath("config") --[[@as string]]
return {
	{
		name = "options",
		event = "VeryLazy",
		dir = conf_path,
	},
}
