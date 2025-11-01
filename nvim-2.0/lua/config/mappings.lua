-- ╭─────────────────────────────────────────────────────────╮
-- │ Key Mappings Configuration                              │
-- │ Core key mappings loaded before plugins                 │
-- ╰─────────────────────────────────────────────────────────╯

local map = vim.keymap.set
local keymaps = {}

keymaps.initial = function()
	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Essential Mappings                                      │
	-- ╰─────────────────────────────────────────────────────────╯
	-- Quick escape from insert mode (custom preference)
	map("i", "jk", "<Esc>")

	-- Clear search highlighting with Escape
	map("n", "<Esc>", "<cmd>nohlsearch<CR>")

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Smart Search Navigation                                 │
	-- ╰─────────────────────────────────────────────────────────╯
	-- Consistent n/N behavior: always search forward with n, backward with N
	-- regardless of search direction (/, ?, *, #)
	-- Source: https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
	map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
	map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
	map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
	map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
	map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
	map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Text Object Helpers                                     │
	-- ╰─────────────────────────────────────────────────────────╯
	-- Select last changed/yanked/put text (custom utility)
	map(
		"n",
		"gV",
		'"`[" . strpart(getregtype(), 0, 1) . "`]"',
		{ expr = true, replace_keycodes = false, desc = "Visually select changed text" }
	)

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Command Line Navigation                                 │
	-- ╰─────────────────────────────────────────────────────────╯
	-- Emacs-style navigation in command mode (custom preference)
	map("c", "<C-h>", "<Home>")  -- Jump to beginning
	map("c", "<C-l>", "<End>")   -- Jump to end
	map("c", "<C-f>", "<Right>") -- Move forward
	map("c", "<C-b>", "<Left>")  -- Move backward

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Plugin Management                                       │
	-- ╰─────────────────────────────────────────────────────────╯
	map("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Show Lazy" })
	map("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Plugins Update" })
end

return keymaps
