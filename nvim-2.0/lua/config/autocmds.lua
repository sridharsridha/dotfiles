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
	autocmd("TextYankPost", {
		group = augroup("yank_highlight"),
		desc = "highlight on yank",
		callback = function()
			vim.highlight.on_yank()
		end,
		pattern = "*",
	})
	autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
		group = augroup("checktime"),
		desc = "Check if we need to reload the file when it changed",
		callback = function()
			if vim.o.buftype ~= "nofile" then
				vim.cmd("checktime")
			end
		end,
	})
	autocmd("VimResized", {
		desc = "resize splits if window got resized",
		group = augroup("resize_splits"),
		callback = function()
			local current_tab = vim.fn.tabpagenr()
			vim.cmd("tabdo wincmd =")
			vim.cmd("tabnext " .. current_tab)
		end,
	})
	autocmd("BufWritePre", {
		desc = "auto create dir when saving a file, in case some intermediate directory does not exist",
		group = augroup("auto_create_dir"),
		callback = function(e)
			if e.match:match("^%w%w+://") then
				return
			end
			local file = vim.loop.fs_realpath(e.match) or e.match
			vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
		end,
	})
	autocmd("CmdlineEnter", {
		desc = "enable hlsearch when entering cmdline",
		pattern = "/,?",
		group = augroup("auto_hlsearch"),
		command = "set hlsearch",
	})
	autocmd("CmdlineLeave", {
		desc = "disable hlsearch when leaving cmdline",
		pattern = "/,?",
		group = augroup("auto_hlsearch"),
		command = "set nohlsearch",
	})
	autocmd("BufWritePost", {
		pattern = "*.scm",
		callback = function()
			require("nvim-treesitter.query").invalidate_query_cache()
		end,
	})
	autocmd("BufWinEnter", {
		desc = "load cursor position, folds of current buffer",
		pattern = "?*",
		group = augroup("remember_folds"),
		callback = function(e)
			if not vim.b[e.buf].view_activated then
				local filetype = vim.api.nvim_get_option_value("filetype", { buf = e.buf })
				local buftype = vim.api.nvim_get_option_value("buftype", { buf = e.buf })
				local ignore_filetypes = { "gitcommit", "gitrebase" }
				if
					buftype == ""
					and filetype
					and filetype ~= ""
					and not vim.tbl_contains(ignore_filetypes, filetype)
				then
					vim.b[e.buf].view_activated = true
					vim.cmd.loadview({ mods = { emsg_silent = true } })
				end
			end
		end,
	})
	---@see https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter
	autocmd("BufEnter", {
		desc = "Find root and change current directory",
		group = augroup("change_root"),
		callback = function(e)
			RootCache = RootCache or {}
			local root_patterns = require("config.global").root_patterns
			local path = vim.api.nvim_buf_get_name(e.buf)
			if path == "" then
				return
			end

			local root = RootCache[vim.fs.dirname(path)]
			if root == nil then
				root = vim.fs.root(e.buf, root_patterns)
				RootCache[path] = root
			end

			if root ~= nil and root ~= "" then
				vim.fn.chdir(root)
			end
		end,
	})
end

autocmds.final = function() end

return autocmds
