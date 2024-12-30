return {
	-- AI completion
	{
		"zbirenbaum/copilot.lua",
		cmd = { "Copilot" },
		event = "InsertEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					suggestion = {
						auto_trigger = true,
						keymap = {
							accept = "<C-S-y>",
							accept_word = false,
							accept_line = false,
							next = "<C-S-n>",
							prev = "<C-S-p>",
							dismiss = "<C-S-]>",
						},
					},
				})

				vim.api.nvim_command("highlight link CopilotAnnotation LineNr")
				vim.api.nvim_command("highlight link CopilotSuggestion LineNr")

				vim.keymap.set("i", "<C-S-e>", function()
					require("cmp").mapping.abort()
					require("copilot.suggestion").accept()
				end, {
					desc = "[copilot] accept suggestion",
					silent = true,
				})
			end, 100)
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		event = { "CmdlineEnter" },
		opts = {
			debug = false,
		},
	},
	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {},
		keys = {
			{
				"gw",
				mode = { "n", "x" },
				function()
					require("wtf").ai()
				end,
				desc = "Debug diagnostic with AI",
			},
			{
				mode = { "n" },
				"gW",
				function()
					require("wtf").search()
				end,
				desc = "Search diagnostic with Google",
			},
		},
	},
}
