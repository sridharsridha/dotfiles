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

	-- Note: Additional autocmds can be added here as needed
	-- Common patterns include:
	-- - Auto-save on focus lost
	-- - Trim trailing whitespace
	-- - Highlight yanked text
	-- - Restore cursor position
end

return M
