return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = true,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				python = { "autopep8", "yarp", "ruff", "black" },
				lua = { "stylua" },
				bash = { "shfmt" },
				cpp = { "clang-format" },
				c = { "clang_format" },
			},
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
				clang_format = {
					prepend_args = { "--style=file", "--fallback-style=LLVM" },
				},
			},
		},
	},
	{
		"zapling/mason-conform.nvim",
		event = "BufReadPre",
		config = true,
		dependencies = {
			"williamboman/mason.nvim",
			"stevearc/conform.nvim",
		},
	},
}
