-- ╭─────────────────────────────────────────────────────────╮
-- │ Autocommands Configuration                              │
-- │ Event-driven automatic commands                         │
-- ╰─────────────────────────────────────────────────────────╯

local M = {}

function M.initial()
	local augroup = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Arista-Specific Filetype Detection                      │
	-- ╰─────────────────────────────────────────────────────────╯
	-- Currently disabled but preserved for reference
	-- These are custom filetypes used at Arista Networks

	-- TAC files (Arista TAC language)
	-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	--   pattern = "*.tac",
	--   callback = function()
	--     vim.bo.filetype = "tac"
	--   end,
	--   group = augroup,
	--   desc = "Detect TAC files for Arista TAC language"
	-- })

	-- ARX files (Arista ARX language)
	-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	--   pattern = "*.arx",
	--   callback = function()
	--     vim.bo.filetype = "arx"
	--   end,
	--   group = augroup,
	--   desc = "Detect ARX files for Arista ARX language"
	-- })

	-- Restore cursor position on file open (replaces nvim-lastplace)
	vim.api.nvim_create_autocmd("BufReadPost", {
		group = augroup,
		callback = function(args)
			local ft = vim.bo[args.buf].filetype
			if ft == "gitcommit" or ft == "gitrebase" then return end
			local bt = vim.bo[args.buf].buftype
			if bt == "quickfix" or bt == "nofile" or bt == "help" then return end
			local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
			local line_count = vim.api.nvim_buf_line_count(args.buf)
			if mark[1] > 0 and mark[1] <= line_count then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
				vim.cmd("normal! zv")
			end
		end,
	})
end

return M
