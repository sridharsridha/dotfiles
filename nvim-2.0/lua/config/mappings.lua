local map = vim.keymap.set
local Keymaps = {}
_G.Keymaps = Keymaps

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

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

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

-- Add empty lines before and after cursor line supporting dot-repeat
Keymaps.put_empty_line = function(put_above)
	-- This has a typical workflow for enabling dot-repeat:
	-- - On first call it sets `operatorfunc`, caches data, and calls
	--   `operatorfunc` on current cursor position.
	-- - On second call it performs task: puts `v:count1` empty lines
	--   above/below current line.
	if type(put_above) == "boolean" then
		vim.o.operatorfunc = "v:lua.Keymaps.put_empty_line"
		Keymaps.cache_empty_line = { put_above = put_above }
		return "g@l"
	end

	local target_line = vim.fn.line(".") - (Keymaps.cache_empty_line.put_above and 1 or 0)
	vim.fn.append(target_line, vim.fn["repeat"]({ "" }, vim.v.count1))
end
map("n", "gO", "v:lua.Keymaps.put_empty_line(v:true)", { expr = true, desc = "Put empty line above" })
map("n", "go", "v:lua.Keymaps.put_empty_line(v:false)", { expr = true, desc = "Put empty line below" })

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
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

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

-- Better block-wise operations on selected area
Keymaps.blockwise_force = function(key)
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
map("x", "I", Keymaps.blockwise_force("I"), { expr = true, noremap = true, desc = "Blockwise Insert" })
map("x", "gI", Keymaps.blockwise_force("gI"), { expr = true, noremap = true, desc = "Blockwise Insert" })
map("x", "A", Keymaps.blockwise_force("A"), { expr = true, noremap = true, desc = "Blockwise Append" })

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

-- Keymaps.toggle_diagnostic = function()
-- 	local new_buf_state = not vim.diagnostic.is_enabled()
-- 	vim.diagnostic.enable(new_buf_state)
-- 	return new_buf_state and "diagnostic is on" or "diagnostic is off"
-- end
--
-- Keymaps.toggle_signcolumn = function()
-- 	vim.wo.signcolumn = vim.wo.signcolumn == "number" and "no" or "number"
-- 	return vim.wo.signcolumn == "number" and "signcolumn = number" or "signcolumn = no"
-- end
--
-- Keymaps.toggle_signnum = function()
-- 	Keymaps.toggle_signcolumn()
-- 	vim.cmd("setlocal number!")
-- 	-- vim.cmd("setlocal relativenumber!")
-- end
--
-- local toggle_prefix = [[\]]
-- local map_toggle = function(lhs, rhs, desc)
-- 	map("n", toggle_prefix .. lhs, rhs, { desc = desc })
-- end
-- map_toggle(
-- 	"b",
-- 	'<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"; print(vim.o.bg)<CR>',
-- 	"Toggle 'background'"
-- )
-- map_toggle("c", "<Cmd>setlocal cursorline! cursorline?<CR>", "Toggle 'cursorline'")
-- map_toggle("C", "<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>", "Toggle 'cursorcolumn'")
-- map_toggle("d", "<Cmd>lua print(Keymaps.toggle_diagnostic())<CR>", "Toggle 'diagnostic'")
-- map_toggle("s", "<Cmd>lua print(Keymaps.toggle_signcolumn())<CR>", "Toggle 'signcolumn'")
-- map_toggle(
-- 	"h",
-- 	'<Cmd>let v:hlsearch = 1 - v:hlsearch | echo (v:hlsearch ? "  " : "no") . "hlsearch"<CR>',
-- 	"Toggle 'search highlight'"
-- )
-- map_toggle("i", "<Cmd>setlocal ignorecase! ignorecase?<CR>", "Toggle 'ignorecase'")
-- map_toggle("l", "<Cmd>setlocal list! list?<CR>", "Toggle 'list'")
-- map_toggle("N", "<Cmd>setlocal number! number?<CR>", "Toggle 'number'")
-- -- map_toggle("r", "<Cmd>setlocal relativenumber! relativenumber?<CR>", "Toggle 'relativenumber'")
-- map_toggle("S", "<Cmd>setlocal spell! spell?<CR>", "Toggle 'spell'")
-- map_toggle("w", "<Cmd>setlocal wrap! wrap?<CR>", "Toggle 'wrap'")
-- map_toggle("n", "<Cmd>lua Keymaps.toggle_signnum()<cr>", "Toggle 'signcolumn and numbers'")
