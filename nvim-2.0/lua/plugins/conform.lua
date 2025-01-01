local function format_hunks()
	local range_ignore_filetypes = { "lua" }
	local format = require("conform").format
	if vim.tbl_contains(range_ignore_filetypes, vim.bo.filetype) then
		format({ lsp_format = "fallback", lsp_fallback = true, timeout_ms = 500 })
		return
	end
	-- Logic to format only the hunks in the file
	local lines = vim.fn.system("git diff --unified=0"):gmatch("[^\n\r]+")
	local ranges = {}
	for line in lines do
		if line:find("^@@") then
			local line_nums = line:match("%+.- ")
			if line_nums:find(",") then
				local _, _, first, second = line_nums:find("(%d+),(%d+)")
				table.insert(ranges, {
					start = { tonumber(first), 0 },
					["end"] = { tonumber(first) + tonumber(second), 0 },
				})
			else
				local first = tonumber(line_nums:match("%d+"))
				table.insert(ranges, {
					start = { first, 0 },
					["end"] = { first + 1, 0 },
				})
			end
		end
	end
	for _, range in pairs(ranges) do
		format({ range = range, lsp_fallback = true })
	end
end
return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "InsertEnter", "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = true,
			default_format_opts = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
				lsp_format = "fallback", -- not recommended to change
			},
			format_on_save = function()
				-- Prefer to format git hunks instead of the entire file
				format_hunks()
			end,
			formatters_by_ft = {
				python = { "yapf", "a" },
				cpp = { "a" },
				tac = { "a" },
				lua = { "stylua" },
			},
			formatters = {
				a = {
					command = "a4",
					args = { "formatfile", "-f", "$FILENAME" },
					stdin = false,
					inherit = false,
				},
			},
		},
	},
}
