return {
	{
		dir = "~/vim-plugins/arista.nvim",
		lazy = false,
		enabled = function()
			return (vim.uv or vim.loop).fs_stat("~/vim-plugins/arista.nvim")
		end,
	},
}
