return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"folke/trouble.nvim",
		},
		keys = {
			{
				"<C-p>",
				function()
					require("fzf-lua").files()
				end,
				desc = "Find files",
			},
			{
				"<leader>ff",
				function()
					require("fzf-lua").files()
				end,
				desc = "Find files",
			},
			{
				"<leader>/",
				function()
					require("fzf-lua").live_grep()
				end,
				desc = "Live grep",
			},
			{
				"<leader>/",
				function()
					require("fzf-lua").grep_visual()
				end,
				mode = "x",
				desc = "Grep selection",
			},
			{
				"<leader>fg",
				function()
					require("fzf-lua").grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>?",
				function()
					require("fzf-lua").builtin()
				end,
				desc = "Fzf builtin",
			},
			{
				"<leader>ld",
				function()
					require("fzf-lua").lsp_definitions()
				end,
				desc = "Definition",
			},
			{
				"<leader>le",
				function()
					require("fzf-lua").diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>lr",
				function()
					require("fzf-lua").lsp_references()
				end,
				desc = "References",
			},
			{
				"<leader>li",
				function()
					require("fzf-lua").lsp_implementations()
				end,
				desc = "Implementation",
			},
			{
				"<leader>lt",
				function()
					require("fzf-lua").lsp_type_definitions()
				end,
				desc = "Type Definition",
			},
			{
				"<leader>ls",
				function()
					require("fzf-lua").lsp_document_symbols()
				end,
				desc = "Document Symbols",
			},
			{
				"<leader>lS",
				function()
					require("fzf-lua").lsp_dynamic_workspace_symbols()
				end,
				desc = "Workspace symbols",
			},
			{
				"<leader>lR",
				function()
					vim.lsp.buf.rename()
				end,
				desc = "Rename",
			},
			{
				"<leader>la",
				function()
					vim.lsp.buf.code_action()
				end,
				desc = "Code Action",
			},
			{
				"K",
				function()
					vim.lsp.buf.hover()
				end,
				"Hover Documentation",
			},
			-- WARN: This is not Goto Definition, this is Goto Declaration.
			--  For example, in C this would take you to the header
			{
				"<leader>lD",
				function()
					vim.lsp.buf.declaration()
				end,
				desc = "Declaration",
			},
		},
		config = function()
			require("fzf-lua").setup()
			local config = require("fzf-lua.config")
			local actions = require("trouble.sources.fzf").actions
			config.defaults.actions.files["ctrl-t"] = actions.open
		end,
	},
}
