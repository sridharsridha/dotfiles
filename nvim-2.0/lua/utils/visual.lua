local M = {}

function M.exit_visual_mode()
	-- Exit visual mode, otherwise `getpos` will return postion of the last visual selection
	local ESC_FEEDKEY = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)
	vim.api.nvim_feedkeys("gv", "x", false)
	vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)
end

function M.get_visual_selection_info()
	M.exit_visual_mode()

	local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
	local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))
	start_row = start_row - 1
	end_row = end_row - 1

	return {
		start_row = start_row,
		start_col = start_col,
		end_row = end_row,
		end_col = end_col,
	}
end

return M