-- ╭─────────────────────────────────────────────────────────╮
-- │ Global Configuration Settings                           │
-- │ Central configuration shared across all modules         │
-- ╰─────────────────────────────────────────────────────────╯

local M = {}

-- ╭─────────────────────────────────────────────────────────╮
-- │ Project Root Detection                                  │
-- ╰─────────────────────────────────────────────────────────╯
--- Root patterns for auto detect and change root
---@type string[]
M.root_patterns = {
	".git",      -- Standard git repository
	"BUILD.qb"   -- Arista-specific build file (custom)
}

-- ╭─────────────────────────────────────────────────────────╮
-- │ Key Mappings                                            │
-- ╰─────────────────────────────────────────────────────────╯
M.mapleader = " "         -- Space as leader key
M.maplocalleader = ","    -- Comma for buffer-local mappings

-- ╭─────────────────────────────────────────────────────────╮
-- │ Editor Preferences                                      │
-- ╰─────────────────────────────────────────────────────────╯
M.netrw_silent = 1        -- Suppress netrw messages (custom)
M.disable_autoformat = true -- Disable auto-formatting by default (custom preference)
M.indent = 3              -- Custom indentation: 3 spaces (Arista style)

-- ╭─────────────────────────────────────────────────────────╮
-- │ UI Configuration                                        │
-- ╰─────────────────────────────────────────────────────────╯
M.is_remote = (vim.env.SSH_CONNECTION ~= nil) or (vim.env.MOSH_CONNECTION ~= nil)
M.use_icons = true        -- Enable icons in UI
M.border = "rounded"      -- Rounded borders for floating windows
M.icons = {
	separator = "-",       -- Note: Fixed typo from 'seperator'
}

return M
