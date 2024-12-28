return {
	{
		"leath-dub/snipe.nvim",
		lazy = true,
		keys = {
      -- stylua: ignore start
      { "<leader><tab>", function() require("snipe").open_buffer_menu() end, desc = "snipe buffer" },
			-- stylua: ignore end
		},
		opts = {},
	},
}
