return {
	-- Code jump
	{
		"rgroli/other.nvim",
		keys = {
			{ "<leader>oo", "<cmd>:Other<CR>", desc = "Other file" },
			{ "<leader>os", "<cmd>:OtherSplit<CR>", desc = "Other file split" },
			{ "<leader>ov", "<cmd>:OtherVSplit<CR>", desc = "Other file vsplit" },
		},
		config = function()
			require("other-nvim").setup({
				showMissingFiles = false,
				keybindings = {
					["<cr>"] = "open_file_by_command()", -- Open the file with last opening command based on how the filepicker was initially opened. (Other, OtherTab, OtherSplit, OtherVSplit)
					["<esc>"] = "close_window()",
					o = "open_file()",
					q = "close_window()",
					v = "open_file_vs()", -- open file in a vertical split
					s = "open_file_sp()", -- open file in a horizontal split
					sv = "open_file_vs()", -- open file in a vertical split
					sh = "open_file_sp()", -- open file in a horizontal split
				},
				mappings = {
					-- custom mapping
					{
						pattern = "/src/(.*)/(.*).tau$",
						target = "/src/%1/ArmPlugin/%2Util.tau",
						component = "Util",
					},
					{
						pattern = "/src/(.*)/ArmPlugin/(.*)Util.tau$",
						target = "/src/%1/%2.tau",
						component = "SwTable",
					},
					{
						pattern = "(.*).h$",
						target = "%1.cpp",
						component = "cpp",
					},
					{
						pattern = "(.*).cpp$",
						target = "%1.h",
						component = "h",
					},
					{
						pattern = "(.*).tac$",
						target = {
							{
								target = "%1.tin",
								component = "tin",
							},
							{
								target = "%1.itin",
								component = "itin",
							},
						},
					},
					{
						pattern = "(.*).tin$",
						target = {
							{
								target = "%1.tac",
								component = "tac",
							},
							{
								target = "%1.itin",
								component = "itin",
							},
						},
					},
					{
						pattern = "(.*).itin$",
						target = {
							{
								target = "%1.tac",
								component = "tac",
							},
							{
								target = "%1.tin",
								component = "tin",
							},
						},
					},
				},
			})
		end,
	},
}
