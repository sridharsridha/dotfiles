local map = vim.keymap.set
local keymaps = {}

keymaps.initial = function()
	map("i", "jk", "<Esc>")
	-- Set highlight on search, but clear on pressing <Esc> in normal mode
	map("n", "<Esc>", "<cmd>nohlsearch<CR>")
	-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
	map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
	map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
	map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
	map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
	map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
	map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
	-- Reselect latest changed, put, or yanked text
	map(
		"n",
		"gV",
		'"`[" . strpart(getregtype(), 0, 1) . "`]"',
		{ expr = true, replace_keycodes = false, desc = "Visually select changed text" }
	)
	-- Navigation in command line
	map("c", "<C-h>", "<Home>")
	map("c", "<C-l>", "<End>")
	map("c", "<C-f>", "<Right>")
	map("c", "<C-b>", "<Left>")

	map("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Show Lazy" })
	map("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Plugins Update" })
end

return keymaps
