-- Snacks profiler code. Trigger profiling using "PROF=1 nvim"
if vim.env.PROF then
	-- example for lazy.nvim
	-- change this to the correct path for your plugin manager
	local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
	vim.opt.rtp:append(snacks)
	require("snacks.profiler").startup({
		startup = {
			event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
		},
	})
end

require("config/options").initial()
require("config/autocmds").initial()
require("config/mappings").initial()
require("config/lazy")
