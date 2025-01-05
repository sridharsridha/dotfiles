return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"folke/trouble.nvim",
		},
		keys = {
			{ "<leader><leader>", "<cmd>FzfLua resume<CR>", mode = "n", desc = "Resume Finder" },
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
				"<leader>fl",
				function()
					require("fzf-lua").live_grep()
				end,
				desc = "Live grep",
			},
			{
				"<leader>fl",
				function()
					require("fzf-lua").grep_visual()
				end,
				mode = "x",
				desc = "Grep selection",
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
				"<leader>fd",
				function()
					require("fzf-lua").lsp_definitions()
				end,
				desc = "Definition",
			},
			{
				"<leader>fx",
				function()
					require("fzf-lua").diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>fr",
				function()
					require("fzf-lua").lsp_references()
				end,
				desc = "References",
			},
			{
				"<leader>fi",
				function()
					require("fzf-lua").lsp_implementations()
				end,
				desc = "Implementation",
			},
			{
				"<leader>ft",
				function()
					require("fzf-lua").lsp_type_definitions()
				end,
				desc = "Type Definition",
			},
			{
				"<leader>fs",
				function()
					require("fzf-lua").lsp_document_symbols()
				end,
				desc = "Document Symbols",
			},
			{
				"<leader>fS",
				function()
					require("fzf-lua").lsp_dynamic_workspace_symbols()
				end,
				desc = "Workspace symbols",
			},
			{
				"<leader>fR",
				function()
					vim.lsp.buf.rename()
				end,
				desc = "Rename",
			},
			{
				"<leader>fa",
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
				"<leader>fD",
				function()
					vim.lsp.buf.declaration()
				end,
				desc = "Declaration",
			},
		},
		config = function()
			require("fzf-lua").setup({
				fzf_colors = { false, ["bg"] = { "" } },
			})
			local config = require("fzf-lua.config")
			local actions = require("trouble.sources.fzf").actions
			config.defaults.actions.files["ctrl-t"] = actions.open
		end,
	},
}
