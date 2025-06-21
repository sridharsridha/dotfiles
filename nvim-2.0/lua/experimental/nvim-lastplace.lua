return {
	{
		"farmergreg/vim-lastplace",
		event = "BufReadPost",
		config = function()
			-- You can customize ignored filetypes and buftypes if needed
			-- These are the defaults and already include 'gitcommit'
			vim.g.lastplace_ignore = "gitcommit,gitrebase,hgcommit,svn,xxd"
			vim.g.lastplace_ignore_buftype = "help,nofile,quickfix,prompt"
			-- Uncomment to disable opening folds
			-- vim.g.lastplace_open_folds = 0
		end,
	},
}
