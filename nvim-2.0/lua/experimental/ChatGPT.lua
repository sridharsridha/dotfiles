return {
	{
		"jackMort/ChatGPT.nvim",
		cmd = { "ChatGPT" },
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim", -- optional
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("chatgpt").setup({
				api_key_cmd = "opai-key.sh", -- Replace with your API key setup
				-- Add custom mappings or adjustments for integration with fzf-lua
			})
		end,
	},
}
