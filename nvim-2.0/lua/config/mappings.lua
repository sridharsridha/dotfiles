local map = vim.keymap.set
local keymaps = {}

keymaps.initial = function()
	map("i", "jk", "<Esc>")
	-- Set highlight on search, but clear on pressing <Esc> in normal mode
	map("n", "<Esc>", "<cmd>nohlsearch<CR>")

	-- Diagnostic keymaps
	map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
	map("n", "<leader>E", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

	-- switch between windows
	map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
	map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
	map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
	map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

	-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
	map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
	map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
	map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
	map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
	map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
	map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

	-- buffer
	map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
	map("n", "<leader>bd", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

	-- Copy/paste with system clipboard
	map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
	map("n", "gp", '"+p', { desc = "Paste from system clipboard" })
	-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
	map("x", "gp", '"+P', { desc = "Paste from system clipboard" })

	-- Reselect latest changed, put, or yanked text
	map(
		"n",
		"gV",
		'"`[" . strpart(getregtype(), 0, 1) . "`]"',
		{ expr = true, replace_keycodes = false, desc = "Visually select changed text" }
	)

	-- Search inside visually highlighted text. Use `silent = false` for it to
	-- make effect immediately.
	map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

	-- Easier line-wise movement
	map("n", "gh", "g^", { desc = "Jump to first screen character" })
	map("n", "gl", "g$", { desc = "Jump to last screen character" })

	-- new file
	map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New File" })

	-- quit
	map("n", "q", ":q<CR>")
	map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

	-- Toggle fold or select option from popup menu
	map("n", "<CR>", function()
		return vim.fn.pumvisible() == 1 and "<CR>" or "za"
	end, { expr = true, desc = "Toggle Fold" })

	-- Focus the current fold by closing all others
	map("n", "<S-Return>", "zMzv", { remap = true, desc = "Focus Fold" })

	-- Re-select blocks after indenting in visual/select mode
	map("x", "<", "<gv", { desc = "Indent Left and Re-select" })
	map("x", ">", ">gv|", { desc = "Indent Right and Re-select" })

	-- Switch */g* and #/g#
	map("n", "*", "g*")
	map("n", "g*", "*")
	map("n", "#", "g#")
	map("n", "g#", "#")

	-- Put vim command output into buffer
	map("n", "g!", ":put=execute('')<Left><Left>", { desc = "Paste Command" })

	-- Navigation in command line
	map("c", "<C-h>", "<Home>")
	map("c", "<C-l>", "<End>")
	map("c", "<C-f>", "<Right>")
	map("c", "<C-b>", "<Left>")

	-- Switch history search pairs, matching my bash shell
	map("c", "<C-p>", function()
		return vim.fn.pumvisible() == 1 and "<C-p>" or "<Up>"
	end, { expr = true })
	map("c", "<C-n>", function()
		return vim.fn.pumvisible() == 1 and "<C-n>" or "<Down>"
	end, { expr = true })

	map("n", "<A-s>", "<Cmd>silent! update | redraw<CR>", { desc = "Save" })
	map({ "i", "x" }, "<A-s>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and go to Normal mode" })

	map("n", "<leader>wx", "<C-w>x<C-w>w", { remap = true, desc = "Swap adjacent windows" })
	map("n", "<leader>ws", "<cmd>split<CR>", { desc = "Split window horizontally" })
	map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
end

keymaps.final = function()
	map("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Show Lazy" })
end

return keymaps
