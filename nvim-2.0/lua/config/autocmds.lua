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
end

autocmds.final = function() end

return autocmds
