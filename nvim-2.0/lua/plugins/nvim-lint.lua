return {
	{
		"mfussenegger/nvim-lint",
		event = "BufReadPre",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {}
			local ignore_buftype = {
				markdown = { "nofile" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
				group = vim.api.nvim_create_augroup("lint", { clear = true }),
				callback = function()
					if ignore_buftype[vim.bo.filetype] then
						for _, buftype in ipairs(ignore_buftype[vim.bo.filetype]) do
							if buftype == vim.bo.buftype then
								return
							end
						end
					end
					lint.try_lint()
				end,
			})
		end,
	},
}
