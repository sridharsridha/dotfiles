return {
	-- search/replace in multiple files
	{
		"MagicDuck/grug-far.nvim",
		opts = {},
		cmd = "GrugFar",
		keys = {
			{
				"<leader>cg",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.grug_far({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
	},
}
