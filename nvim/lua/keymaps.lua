local map = vim.keymap.set

-- Set highlight on search, but clear on pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
-- map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
-- map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
-- map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

map("n", "<C-t>", ":Term<CR>", { noremap = true, desc = "Enter termial mode" }) -- open
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("i", "jk", "<ESC>", { silent = true })
map("i", "kj", "<ESC>", { silent = true })

-- Moves through display-lines, unless count is provided
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Easier line-wise movement
map("n", "gh", "g^", { desc = "Jump to first screen character" })
map("n", "gl", "g$", { desc = "Jump to last screen character" })

-- Navigation in command line
map("c", "<C-h>", "<Home>")
map("c", "<C-l>", "<End>")
map("c", "<C-f>", "<Right>")
map("c", "<C-b>", "<Left>")

map("n", "<Enter>", "o<ESC>")
map("n", "q", ":q<CR>")
map("n", "<C-q>", ":q!<CR>")

-- Toggle fold or select option from popup menu
map("n", "<CR>", function()
	return vim.fn.pumvisible() == 1 and "<CR>" or "za"
end, { expr = true, desc = "Toggle Fold" })

-- Focus the current fold by closing all others
map("n", "<S-Return>", "zMzv", { remap = true, desc = "Focus Fold" })

-- Select last paste
map("n", "gpp", "'`['.strpart(getregtype(), 0, 1).'`]'", { expr = true, desc = "Select Paste" })
-- Re-select blocks after indenting in visual/select mode
map("x", "<", "<gv", { desc = "Indent Right and Re-select" })
map("x", ">", ">gv|", { desc = "Indent Left and Re-select" })

-- Use tab for indenting in visual/select mode
map("x", "<Tab>", ">gv|", { desc = "Indent Left" })
map("x", "<S-Tab>", "<gv", { desc = "Indent Right" })

-- Better block-wise operations on selected area
local blockwise_force = function(key)
	local c_v = vim.api.nvim_replace_termcodes("<C-v>", true, false, true)
	local keyseq = {
		I = { v = "<C-v>I", V = "<C-v>^o^I", [c_v] = "I" },
		A = { v = "<C-v>A", V = "<C-v>0o$A", [c_v] = "A" },
		gI = { v = "<C-v>0I", V = "<C-v>0o$I", [c_v] = "0I" },
	}
	return function()
		return keyseq[key][vim.fn.mode()]
	end
end
map("x", "I", blockwise_force("I"), { expr = true, noremap = true, desc = "Blockwise Insert" })
map("x", "gI", blockwise_force("gI"), { expr = true, noremap = true, desc = "Blockwise Insert" })
map("x", "A", blockwise_force("A"), { expr = true, noremap = true, desc = "Blockwise Append" })

-- Switch */g* and #/g#
map("n", "*", "g*")
map("n", "g*", "*")
map("n", "#", "g#")
map("n", "g#", "#")

-- Use backspace key for matching pairs
map({ "n", "x" }, "<BS>", "%", { remap = true, desc = "Jump to Paren" })

-- Start an external command with a single bang
map("n", "!", ":!", { desc = "Execute Shell Command" })

-- Put vim command output into buffer
map("n", "g!", ":put=execute('')<Left><Left>", { desc = "Paste Command" })

-- Switch history search pairs, matching my bash shell
---@return string
map("c", "<C-p>", function()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<Up>"
end, { expr = true })

map("c", "<C-n>", function()
	return vim.fn.pumvisible() == 1 and "<C-n>" or "<Down>"
end, { expr = true })

map("c", "<Up>", "<C-p>")
map("c", "<Down>", "<C-n>")

-- Allow misspellings
local cabbrev = vim.cmd.cnoreabbrev
cabbrev("qw", "wq")
cabbrev("Wq", "wq")
cabbrev("WQ", "wq")
cabbrev("Qa", "qa")
cabbrev("Bd", "bd")
cabbrev("bD", "bd")

map({ "n", "i", "v" }, "<C-s>", "<cmd>write<CR>", { desc = "Save" })

-- Switch with adjacent window
map("n", "<C-x>", "<C-w>x<C-w>w", { remap = true, desc = "Swap adjacent windows" })
map("n", "sb", "<cmd>buffer#<CR>", { desc = "Alternate buffer" })
map("n", "sc", "<cmd>close<CR>", { desc = "Close window" })
map("n", "sd", "<cmd>bdelete<CR>", { desc = "Buffer delete" })
map("n", "sx", "<cmd>split<CR>", { desc = "Split window horizontally" })
map("n", "sv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
map("n", "st", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "so", "<cmd>only<CR>", { desc = "Close other windows" })
map("n", "sq", "<cmd>quit<CR>", { desc = "Quit" })
