local M = {}

--- Root patterns for auto detect and change root
---@type string[]
M.root_patterns = { ".git", "BUILD.qb" }
M.mapleader = " "
M.maplocalleader = ","
M.netrw_silent = 1
M.disable_autoformat = false
M.use_icons = true

return M
