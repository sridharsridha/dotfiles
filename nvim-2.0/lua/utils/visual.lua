-- ╭─────────────────────────────────────────────────────────╮
-- │ Visual Mode Utility Functions                           │
-- │ Helper functions for working with visual selections     │
-- ╰─────────────────────────────────────────────────────────╯

local M = {}

--- Exit visual mode cleanly
-- Ensures we get accurate position information
function M.exit_visual_mode()
	-- Exit visual mode, otherwise `getpos` will return position of the last visual selection
	local ESC_FEEDKEY = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true) -- Exit visual mode
	vim.api.nvim_feedkeys("gv", "x", false)        -- Reselect visual
	vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)  -- Exit again
end

--- Get detailed information about the current visual selection
-- @return table Information about selection with start/end row/col (0-indexed)
function M.get_visual_selection_info()
	M.exit_visual_mode()

	-- Get visual selection marks ('< and '>)
	local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
	local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))

	-- Convert to 0-indexed for Neovim API compatibility
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