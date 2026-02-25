-- ╭─────────────────────────────────────────────────────────╮
-- │ LSP Configuration                                       │
-- │ Language Server Protocol setup for code intelligence    │
-- ╰─────────────────────────────────────────────────────────╯

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" }, -- Load on file open
	dependencies = {
		"williamboman/mason.nvim",            -- LSP installer
		"williamboman/mason-lspconfig.nvim",  -- Mason-LSPConfig bridge
		"saghen/blink.cmp",                   -- For LSP capabilities
	},
	config = function()
		local keymap = vim.keymap

		-- ╭─────────────────────────────────────────────────────────╮
		-- │ LSP Attach Autocommand                                  │
		-- │ Set up keymaps and features when LSP attaches to buffer │
		-- ╰─────────────────────────────────────────────────────────╯
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspMapping", { clear = true }),
			callback = function(ev)
				-- Buffer local mappings
				local opts = { buffer = ev.buf, silent = true }

				-- -- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = ev.buf,
						group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true }),
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = ev.buf,
						group = vim.api.nvim_create_augroup("lsp_document_highlight_clear", { clear = true }),
						callback = vim.lsp.buf.clear_references,
					})
				end

				-- Navigation
				opts.desc = "Go to declaration"
				keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "<leader>cd", vim.lsp.buf.definition, opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "<leader>ct", vim.lsp.buf.type_definition, opts)

				opts.desc = "Show LSP references"
				keymap.set("n", "<leader>cr", vim.lsp.buf.references, opts)

				-- Code actions
				opts.desc = "Show available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>cR", vim.lsp.buf.rename, opts)

				-- Diagnostics
				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", vim.diagnostic.setloclist, opts)

				-- Documentation
				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Show signature help"
				keymap.set({ "n", "i" }, "<C-S>", vim.lsp.buf.signature_help, opts)

				-- Workspace
				opts.desc = "Add workspace folder"
				keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)

				opts.desc = "Remove workspace folder"
				keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)

				opts.desc = "List workspace folders"
				keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)

				-- Formatting
				-- opts.desc = "Format document"
				-- keymap.set("n", "<leader>cf", function()
				-- 	vim.lsp.buf.format({ async = true })
				-- end, opts)

				-- LSP management
				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", opts)

				opts.desc = "LSP Info"
				keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", opts)

				-- Inlay hints toggle
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					opts.desc = "Toggle inlay hints"
					keymap.set("n", "<leader>ih", function()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
							{ bufnr = ev.buf }
						)
					end, opts)
				end
			end,
		})

		-- ╭─────────────────────────────────────────────────────────╮
		-- │ LSP Capabilities Setup                                  │
		-- │ Configure completion and snippet support                │
		-- ╰─────────────────────────────────────────────────────────╯
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- Extend with blink.cmp capabilities for better completion
		capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		-- ╭─────────────────────────────────────────────────────────╮
		-- │ Diagnostic Configuration                                │
		-- │ Customize how errors and warnings are displayed         │
		-- ╰─────────────────────────────────────────────────────────╯
		local x = vim.diagnostic.severity
		vim.diagnostic.config({
			virtual_text = { prefix = "●" },
			signs = {
				text = {
					[x.ERROR] = " ",
					[x.WARN] = " ",
					[x.HINT] = " ",
					[x.INFO] = " ",
				},
			},
			underline = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
			},
			severity_sort = true,
			update_in_insert = false,
		})

		-- Enable inlay hints globally (custom preference)
		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(true)
		end

		-- ╭─────────────────────────────────────────────────────────╮
		-- │ LSP Server Configurations                               │
		-- │ Using native vim.lsp.config API (Neovim 0.11+)          │
		-- ╰─────────────────────────────────────────────────────────╯

		-- ════════════════════════════════════════════════════════════
		-- Arista Custom Language Servers
		-- Company-specific LSP servers for internal languages
		-- ════════════════════════════════════════════════════════════

		-- ArGrok - Arista code navigation and search
		-- vim.lsp.config("argrok", {
		-- 	cmd = { "/home/sridharn/bin/artoolslsp/ar-grok-ls" },
		-- 	filetypes = { "c", "cpp", "python" },
		-- 	root_dir = "/src/",
		-- 	settings = { debug = false },
		-- 	capabilities = capabilities,
		-- })

		-- ArFormatDiff - Arista format checking
		-- vim.lsp.config("arformatdiff", {
		-- 	cmd = { "/home/sridharn/bin/artoolslsp/ar-formatdiff-ls" },
		-- 	filetypes = { "c", "cpp", "python" },
		-- 	root_dir = "/src/",
		-- 	settings = { debug = false },
		-- 	capabilities = capabilities,
		-- })

		-- ArPylint - Arista Python linting
		-- vim.lsp.config("arpylint", {
		-- 	cmd = { "/home/sridharn/bin/artoolslsp/ar-pylint-ls" },
		-- 	filetypes = { "python" },
		-- 	root_dir = "/src/",
		-- 	settings = { debug = false },
		-- 	capabilities = capabilities,
		-- })

		-- ArEx - Arista ARX language server
		vim.lsp.config("arex", {
			cmd = { "/usr/bin/arexlsp" },
			filetypes = { "arx" },
			root_dir = "/src/",
			capabilities = capabilities,
		})

		-- TACC - Arista TAC language server
		vim.lsp.config("tacc", {
			cmd = { "/usr/bin/artaclsp", "-I", "/bld/" }, -- Include build directory
			filetypes = { "tac" },
			root_dir = "/src/",
			capabilities = capabilities,
		})

		-- ════════════════════════════════════════════════════════════
		-- Standard Language Servers
		-- General-purpose LSP servers with custom configurations
		-- ════════════════════════════════════════════════════════════

		-- Clangd - C/C++ language server with Arista-specific settings
		vim.lsp.config("clangd", {
         -- cmd = { "clangd", "--background-index", "--clang-tidy" },
			cmd = {
				"/usr/bin/clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
				"--pch-storage=memory",
				"--compile-commands-dir=/src",
				"--offset-encoding=utf-16",
				"-j=40",
				"--pretty",
			},
         root_dir = "/src",
			init_options = {
            compilationDatabasePath = "/src",
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
         capabilities = capabilities;
			-- capabilities = vim.tbl_deep_extend("force", capabilities, {
			-- 	offsetEncoding = { "utf-16" },
			-- }),
		})

		-- Lua Language Server - For Neovim config and Lua development
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT", -- Neovim uses LuaJIT
					},
					diagnostics = {
						globals = { "vim" }, -- Recognize vim global
						disable = { "missing-fields" }, -- Too noisy
					},
					workspace = {
						checkThirdParty = false, -- Don't prompt about third-party
						library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime
					},
					completion = {
						callSnippet = "Replace", -- Better snippet behavior
					},
					telemetry = {
						enable = false, -- Privacy
					},
				},
			},
			capabilities = capabilities,
		})

		-- Ruff - Native fast Python linter and formatter
		-- Much faster than traditional Python linters, optimized for large codebases
		vim.lsp.config("ruff", {
			cmd = { "ruff", "server" },
			filetypes = { "python" },
			root_dir = "/src/",
			settings = {
				-- Ruff server configuration
				-- See: https://docs.astral.sh/ruff/editors/settings/
				lint = {
					enable = true,
				},
				format = {
					enable = true,
				},
				organizeImports = {
					enable = true,
				},
			},
			capabilities = capabilities,
		})

		-- Jedi Language Server - Lightweight Python LSP alternative to basedpyright
		-- Uncomment to use instead of basedpyright for better performance on large codebases
		vim.lsp.config("jedi_language_server", {
			cmd = { "jedi-language-server" },
			filetypes = { "python" },
			root_dir = "/src/",
			init_options = {
				completion = {
					disableSnippets = false,
					resolveEagerly = false,
				},
				diagnostics = {
					enable = false, -- Let Ruff handle diagnostics
				},
				hover = {
					enable = true,
				},
				workspace = {
					symbols = {
						maxSymbols = 20,
					},
				},
			},
			capabilities = capabilities,
		})

		-- ╭─────────────────────────────────────────────────────────╮
		-- │ LSP Server Enablement                                   │
		-- │ Activate configured servers with conditional checks     │
		-- ╰─────────────────────────────────────────────────────────╯

		-- Standard servers (always enable, assume they're installed via Mason)
		vim.lsp.enable("clangd")
		vim.lsp.enable("lua_ls")

		-- Python LSP configuration
		if vim.fn.executable("jedi-language-server") == 1 then
			vim.lsp.enable("jedi_language_server")
		end
		-- Ruff - Fast Python linter/formatter (can be used alongside any Python LSP)
		-- Uses the native ruff server (ruff >= 0.5.0)
		if vim.fn.executable("ruff") == 1 then
			vim.lsp.enable("ruff")
		end

		-- Arista custom servers (only enable if executable exists)
		-- if vim.fn.executable("/home/sridharn/bin/artoolslsp/ar-grok-ls") == 1 then
		-- 	vim.lsp.enable("argrok")
		-- end
		--
		-- if vim.fn.executable("/home/sridharn/bin/artoolslsp/ar-formatdiff-ls") == 1 then
		-- 	vim.lsp.enable("arformatdiff")
		-- end
		--
		-- if vim.fn.executable("/home/sridharn/bin/artoolslsp/ar-pylint-ls") == 1 then
		-- 	vim.lsp.enable("arpylint")
		-- end

		if vim.fn.executable("/usr/bin/arexlsp") == 1 then
			vim.lsp.enable("arex")
		end

		if vim.fn.executable("/usr/bin/artaclsp") == 1 then
			vim.lsp.enable("tacc")
		end
	end,
}
