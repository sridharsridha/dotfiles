return {
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = { "InsertEnter" },
		opts = {},
	},
   {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
    keys = {
      {
        "<leader>cr",
        function()
          return ":IncRename " .. vim.fn.expand "<cword>"
        end,
        expr = true,
        desc = "rename",
      },
    },
  },
  { "folke/ts-comments.nvim", event = "BufReadPre", opts = {} },
}
