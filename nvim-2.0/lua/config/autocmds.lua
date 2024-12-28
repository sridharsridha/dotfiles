-- Autocommand functions
--
-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, {})
end
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

local autocmds = {}

autocmds.initial = function()
	-- Check if we need to reload the file when it changed
	autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
		group = augroup("checktime"),
		callback = function()
			if vim.o.buftype ~= "nofile" then
				vim.cmd("checktime")
			end
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
end

autocmds.final = function() end

return autocmds
