local opt = vim.opt
local g = vim.g
local gl = require("config/global")

local opts = {}

opts.initial = function()
	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Disable Unused Providers                                │
	-- ╰─────────────────────────────────────────────────────────╯
	g.loaded_node_provider = 0
	g.loaded_perl_provider = 0
	g.loaded_ruby_provider = 0

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Leader Key Configuration                                │
	-- ╰─────────────────────────────────────────────────────────╯
	g.mapleader = gl.mapleader -- Space as leader key (custom)

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ File & Search Settings                                  │
	-- ╰─────────────────────────────────────────────────────────╯
	-- opt.path:append("**") -- Removed: causes recursive scan on large repos, Telescope handles file finding
	opt.ignorecase = true -- Case-insensitive search
	opt.smartcase = true -- Override ignorecase if search has uppercase
	opt.inccommand = "split" -- Show substitution results in split preview

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ UI & Visual Settings                                    │
	-- ╰─────────────────────────────────────────────────────────╯
	opt.pumblend = 0 -- No transparency in popup menus (custom preference)
	opt.showmode = false -- Don't show mode (using lualine instead)
	opt.termguicolors = true -- Enable 24-bit RGB colors
	opt.cursorline = not gl.is_remote -- Highlight current line (disable over SSH/mosh for perf)
	opt.number = true -- Show line numbers
	-- opt.relativenumber = false -- Default is false, removed redundancy
	opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor
	opt.signcolumn = "yes" -- Always show sign column to prevent shifting
	-- opt.laststatus = 2 -- Default is 2, removed redundancy
	opt.colorcolumn = "85" -- Shows vertical line at 85
	opt.textwidth = 85     -- Formats text to 85 columns

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Editor Behavior                                         │
	-- ╰─────────────────────────────────────────────────────────╯
	opt.clipboard = "unnamed,unnamedplus"
	-- Use OSC 52 for clipboard over SSH/mosh (requires terminal + tmux support)
	if gl.is_remote then
		vim.g.clipboard = {
			name = "OSC 52",
			copy = {
				["+"] = require("vim.ui.clipboard.osc52").copy("+"),
				["*"] = require("vim.ui.clipboard.osc52").copy("*"),
			},
			paste = {
				["+"] = require("vim.ui.clipboard.osc52").paste("+"),
				["*"] = require("vim.ui.clipboard.osc52").paste("*"),
			},
		}
	end
	opt.completeopt = { "menuone", "noselect", "noinsert" } -- Better completion experience
	opt.shortmess:append("aoOt") -- Shorter messages (custom: a=abbreviate, o=overwrite, O=file read, t=truncate)
	opt.timeoutlen = 200 -- Faster key sequence completion (custom: default is 1000)
	opt.updatetime = gl.is_remote and 1000 or 300 -- CursorHold delay (longer over SSH/mosh)

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Splits Configuration                                    │
	-- ╰─────────────────────────────────────────────────────────╯
	opt.splitbelow = true -- Horizontal splits go below
	opt.splitright = true -- Vertical splits go right

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Indentation Settings                                    │
	-- ╰─────────────────────────────────────────────────────────╯
	opt.tabstop = gl.indent -- Tab width (custom: 3 spaces from global config)
	opt.shiftwidth = gl.indent -- Indent width (custom: 3 spaces from global config)
	opt.expandtab = true -- Use spaces instead of tabs

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Backup & Undo Settings                                  │
	-- ╰─────────────────────────────────────────────────────────╯
	opt.swapfile = false -- Disable swap files (custom preference)
	opt.undofile = true -- Enable persistent undo
	opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- Custom undo directory

	-- Performance: reduce redraws over SSH/mosh
	if gl.is_remote then
		opt.lazyredraw = true -- Don't redraw during macros/mappings
		opt.synmaxcol = 200 -- Limit syntax highlighting to first 200 columns
		opt.redrawtime = 1000 -- Limit syntax highlighting redraw time (default 2000)
	end
end

-- ╭─────────────────────────────────────────────────────────╮
-- │ Performance Optimization: Lazy Shada Loading            │
-- ╰─────────────────────────────────────────────────────────╯
-- Custom optimization: Defer shada (shared data) file loading
-- to speed up startup time. Shada stores command history, marks, etc.
local shada = vim.o.shada
vim.o.shada = "" -- Temporarily disable shada
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.o.shada = shada -- Restore shada settings
		pcall(vim.cmd.rshada, { bang = true }) -- Read shada file
	end,
})

return opts
