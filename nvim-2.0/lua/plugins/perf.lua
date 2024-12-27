return {
	{
		"folke/snacks.nvim",
		optional = true,
		opts = function()
			-- Toggle the profiler
			Snacks.toggle.profiler():map("<leader>pp")
			-- Toggle the profiler highlights
			Snacks.toggle.profiler_highlights():map("<leader>ph")
		end,
		keys = {
			{
				"<leader>ps",
				function()
					Snacks.profiler.scratch()
				end,
				desc = "Profiler Scratch Bufer",
			},
		},
	},

	{
		"dstein64/vim-startuptime",
		lazy = true,
		-- lazy-load on a command
		cmd = "StartupTime",
		-- init is called during startup. Configuration for vim plugins typically should be set in an init function
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},
}
