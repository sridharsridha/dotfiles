-- Autocommand functions

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local function augroup(name)
	return vim.api.nvim_create_augroup("sri_" .. name, {})
end
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup("YankHighlight"),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = "800" })
	end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Go to last loc when opening a buffer, see ':h last-position-jump'
autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit", "commit", "gitrebase" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Fix conceallevel for json files
autocmd({ "FileType" }, {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

autocmd("BufWritePre", {
	group = augroup("undo_disable"),
	pattern = { "/tmp/*", "*.tmp", "*.bak", "COMMIT_EDITMSG", "MERGE_MSG" },
	callback = function(event)
		vim.opt_local.undofile = false
		if event.file == "COMMIT_EDITMSG" or event.file == "MERGE_MSG" then
			vim.opt_local.swapfile = false
		end
	end,
	desc = "Disable swap/undo/backup files in temp directories or shm",
})

autocmd({ "BufNewFile", "BufReadPre" }, {
	group = augroup("secure"),
	pattern = {
		"/tmp/*",
		"$TMPDIR/*",
		"$TMP/*",
		"$TEMP/*",
		"*/shm/*",
		"/private/var/*",
	},
	callback = function()
		vim.opt_local.undofile = false
		vim.opt_local.swapfile = false
		vim.opt_global.backup = false
		vim.opt_global.writebackup = false
	end,
	desc = "Disable swap/undo/backup files in temp directories or shm",
})
