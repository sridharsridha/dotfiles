-- ╭─────────────────────────────────────────────────────────╮
-- │ Conform.nvim Configuration with Gitsigns Integration    │
-- │                                                         │
-- │ Features:                                               │
-- │ - Format only changed lines (git hunks) using gitsigns │
-- │ - LSP fallback with range support for changed lines    │
-- │ - Smart format mode switching (hunks vs entire buffer) │
-- │ - User commands for controlling format behavior        │
-- │                                                         │
-- │ Keymaps:                                                │
-- │ - <leader>cf : Format changed hunks only               │
-- │ - <leader>cF : Format entire buffer                    │
-- │ - <leader>cH : Toggle format mode                      │
-- │                                                         │
-- │ Commands:                                               │
-- │ - :FormatEnable  : Enable autoformat on save           │
-- │ - :FormatDisable : Disable autoformat on save          │
-- │ - :FormatHunks   : Format only changed hunks           │
-- │ - :FormatBuffer  : Format entire buffer                │
-- │                                                         │
-- │ Default Behavior:                                       │
-- │ - Autoformat is DISABLED by default                    │
-- │ - When enabled, formats only changed lines on save     │
-- │ - Falls back to LSP when no formatter is configured    │
-- ╰─────────────────────────────────────────────────────────╯

-- ╭─────────────────────────────────────────────────────────╮
-- │ Format only changed lines using gitsigns               │
-- ╰─────────────────────────────────────────────────────────╯
local function format_hunks(opts)
	opts = opts or {}
	local conform = require("conform")

	-- Check if gitsigns is available
	local has_gitsigns, gitsigns = pcall(require, "gitsigns")
	if not has_gitsigns then
		-- Fallback to regular format if gitsigns is not available
		vim.notify("Gitsigns not available, formatting entire buffer", vim.log.levels.WARN)
		return conform.format({
			lsp_format = "fallback",
			lsp_fallback = true,
			timeout_ms = opts.timeout_ms or 2000,
		})
	end

	-- Get the current buffer
	local bufnr = vim.api.nvim_get_current_buf()

	-- Check if buffer is tracked by git
	if not gitsigns.get_actions() then
		vim.notify("Buffer not tracked by git, formatting entire buffer", vim.log.levels.INFO)
		return conform.format({
			lsp_format = "fallback",
			lsp_fallback = true,
			timeout_ms = opts.timeout_ms or 2000,
		})
	end

	-- Get hunks from gitsigns
	local hunks = gitsigns.get_hunks(bufnr)

	if not hunks or vim.tbl_isempty(hunks) then
		vim.notify("No changes detected", vim.log.levels.INFO)
		return
	end

	-- Convert hunks to conform ranges
	local ranges = {}
	for _, hunk in ipairs(hunks) do
		if hunk.type ~= "delete" then
			-- For added and changed lines
			local start_line = hunk.added.start
			local end_line = hunk.added.start + hunk.added.count - 1

			-- Ensure valid range
			if start_line > 0 and end_line >= start_line then
				table.insert(ranges, {
					start = { start_line, 0 },
					["end"] = { end_line + 1, 0 }, -- +1 because end is exclusive
				})
			end
		end
	end

	if vim.tbl_isempty(ranges) then
		vim.notify("No formattable changes detected", vim.log.levels.INFO)
		return
	end

	-- Check if we should use LSP formatting for this filetype
	local formatters = conform.list_formatters(bufnr)
	local use_lsp = vim.tbl_isempty(formatters)

	if use_lsp then
		-- Format with LSP for each range
		local lsp_format = function(range)
			vim.lsp.buf.format({
				bufnr = bufnr,
				timeout_ms = opts.timeout_ms or 2000,
				range = {
					start = range.start,
					["end"] = range["end"],
				},
			})
		end

		-- Format each hunk with LSP
		for _, range in ipairs(ranges) do
			lsp_format(range)
		end

		vim.notify(string.format("Formatted %d hunks with LSP", #ranges), vim.log.levels.INFO)
	else
		-- Format each hunk with conform
		local format_count = 0
		for _, range in ipairs(ranges) do
			local ok = pcall(conform.format, {
				bufnr = bufnr,
				range = range,
				lsp_format = "fallback",
				timeout_ms = opts.timeout_ms or 2000,
			})
			if ok then
				format_count = format_count + 1
			end
		end

		if format_count > 0 then
			vim.notify(string.format("Formatted %d/%d hunks", format_count, #ranges), vim.log.levels.INFO)
		end
	end
end

-- ╭─────────────────────────────────────────────────────────╮
-- │ Format entire buffer                                    │
-- ╰─────────────────────────────────────────────────────────╯
local function format_buffer(opts)
	opts = opts or {}
	require("conform").format({
		async = opts.async or false,
		lsp_format = "fallback",
		lsp_fallback = true,
		timeout_ms = opts.timeout_ms or 2000,
	})
end

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		dependencies = {
			"lewis6991/gitsigns.nvim", -- For getting changed hunks
		},
		init = function()
			vim.g.disable_autoformat = true
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

			-- User commands for controlling autoformat
			vim.api.nvim_create_user_command("FormatDisable", function()
				vim.g.disable_autoformat = true
				vim.notify("Autoformat disabled", vim.log.levels.INFO)
			end, {
				desc = "Disable autoformat-on-save",
				bang = false,
			})

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.g.disable_autoformat = false
				vim.notify("Autoformat enabled", vim.log.levels.INFO)
			end, {
				desc = "Re-enable autoformat-on-save",
			})

			-- Additional commands for formatting
			vim.api.nvim_create_user_command("FormatHunks", function()
				format_hunks({ timeout_ms = 3000 })
			end, {
				desc = "Format only changed hunks",
			})

			vim.api.nvim_create_user_command("FormatBuffer", function()
				format_buffer({ timeout_ms = 3000 })
			end, {
				desc = "Format entire buffer",
			})
		end,
		keys = {
			{
				"<leader>cF",
				function()
					format_buffer({ async = true })
				end,
				mode = { "n", "v" },
				desc = "Format entire buffer",
			},
			{
				"<leader>cf",
				function()
					format_hunks()
				end,
				mode = { "n", "v" },
				desc = "Format changed hunks only",
			},
			{
				"<leader>cH",
				function()
					-- Toggle between formatting modes
					if vim.g.format_mode == "hunks" then
						vim.g.format_mode = "buffer"
						vim.notify("Format mode: entire buffer", vim.log.levels.INFO)
					else
						vim.g.format_mode = "hunks"
						vim.notify("Format mode: changed hunks only", vim.log.levels.INFO)
					end
				end,
				mode = { "n" },
				desc = "Toggle format mode (hunks/buffer)",
			},
		},
		opts = {
			notify_on_error = true,
			default_format_opts = {
				lsp_format = "fallback", -- not recommended to change
			},
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end

				-- Check format mode preference (default to hunks)
				local format_mode = vim.g.format_mode or "hunks"

				if format_mode == "hunks" then
					-- Format only changed hunks
					-- Run synchronously for save operation
					vim.schedule(function()
						format_hunks({ timeout_ms = 1000 })
					end)
					-- Return false to prevent default formatting
					return false
				else
					-- Format entire buffer
					return {
						lsp_format = "fallback",
						timeout_ms = 1000,
					}
				end
			end,
			formatters_by_ft = {
				python = { "yapf" },
				cpp = { "a" },
				tac = { "a" },
				lua = { "stylua" },
				-- Add more formatters as needed
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
			},
			formatters = {
				a = {
					command = "a4",
					args = { "formatfile", "-f", "$FILENAME" },
					stdin = false,
					inherit = false,
				},
				-- Configure prettier to also respect .editorconfig
				prettier = {
					prepend_args = { "--prose-wrap", "always" },
				},
			},
		},
	},
}
