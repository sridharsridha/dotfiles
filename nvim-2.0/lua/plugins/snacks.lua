return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		enabled = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			indent = { enabled = false },
			input = { enabled = true },
			notifier = {
				enabled = false,
				timeout = 3000,
			},
			quickfile = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = true },
			styles = {
				notification = {
					wo = { wrap = true }, -- Wrap notifications
				},
			},
			toggle = {
				enabled = true,
				which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
				notify = true, -- show a notification when toggling
			},
			-- terminal = {
			-- 	enabled = false,
			-- 	keys = {
			-- 		q = "hide",
			-- 		gf = function(self)
			-- 			local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
			-- 			if f == "" then
			-- 				Snacks.notify.warn("No file under cursor")
			-- 			else
			-- 				self:hide()
			-- 				vim.schedule(function()
			-- 					vim.cmd("e " .. f)
			-- 				end)
			-- 			end
			-- 		end,
			-- 		term_normal = {
			-- 			"<esc>",
			-- 			function(self)
			-- 				self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
			-- 				if self.esc_timer:is_active() then
			-- 					self.esc_timer:stop()
			-- 					vim.cmd("stopinsert")
			-- 				else
			-- 					self.esc_timer:start(300, 0, function() end)
			-- 					return "<esc>"
			-- 				end
			-- 			end,
			-- 			mode = "t",
			-- 			expr = true,
			-- 			desc = "Double escape to normal mode",
			-- 		},
			-- 	},
			-- },
		},
		keys = {
			{
				"<leader>ps",
				function()
					Snacks.profiler.scratch()
				end,
				desc = "Profiler Scratch Bufer",
			},
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>Z",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom",
			},
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			{
				"<leader>n",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>cR",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
				mode = { "n", "v" },
			},
			{
				"<leader>gb",
				function()
					Snacks.git.blame_line()
				end,
				desc = "Git Blame Line",
			},
			{
				"<leader>gf",
				function()
					Snacks.lazygit.log_file()
				end,
				desc = "Lazygit Current File History",
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gl",
				function()
					Snacks.lazygit.log()
				end,
				desc = "Lazygit Log (cwd)",
			},
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			-- {
			-- 	"<c-/>",
			-- 	function()
			-- 		Snacks.terminal().toggle()
			-- 	end,
			-- 	desc = "Toggle Terminal",
			-- },
			-- {
			-- 	"<c-_>",
			-- 	function()
			-- 		Snacks.terminal()
			-- 	end,
			-- 	desc = "which_key_ignore",
			-- },
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Reference",
				mode = { "n", "t" },
			},
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev Reference",
				mode = { "n", "t" },
			},
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
					-- Toggle the profiler
					Snacks.toggle.profiler():map("<leader>pp")
					-- Toggle the profiler highlights
					Snacks.toggle.profiler_highlights():map("<leader>ph")
				end,
			})
		end,
	},
}
