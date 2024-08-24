return {
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("sri-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-T>.
					map("<leader>cd", require("telescope.builtin").lsp_definitions, "[C]ode [D]efinition")

					-- Find references for the word under your cursor.
					map("<leader>cr", require("telescope.builtin").lsp_references, "[C]ode [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("<leader>ci", require("telescope.builtin").lsp_implementations, "[C]ode [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>ct", require("telescope.builtin").lsp_type_definitions, "[C]ode [T]ype Definition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace
					--  Similar to document symbols, except searches over your whole project.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header
					map("<leader>cD", vim.lsp.buf.declaration, "[C]ode [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				clangd = {
					cmd = {
						"/usr/bin/clangd",
						"--pretty",
						"-j=40",
						"--pch-storage=memory",
						"--clang-tidy",
						"--compile-commands-dir=/src",
					},
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
					capabilities = { offsetEncoding = "utf-8" },
				},
				-- pyright = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Tells lua_ls where to find all the Lua files that you have loaded
								-- for your neovim configuration.
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
								-- If lua_ls is really slow on your computer, you can try this instead:
								-- library = { vim.env.VIMRUNTIME },
							},
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
							diagnostics = { globals = { "vim" } },
						},
					},
				},
			}

			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			local sri_custom_lsp_start = vim.api.nvim_create_augroup("sri-custom-lsp-start", { clear = true })
			-- Setup custom LSP servers for different filetypes.
			-- Take a look at server configuration in nvim-lspconfig
			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				group = sri_custom_lsp_start,
				pattern = { "*.tac" },
				callback = function()
					vim.lsp.start({
						name = "tacc",
						cmd = { "/usr/bin/artaclsp" },
						cmd_args = { "-I", "/bld/" },
						root_dir = "/src",
					})
				end,
			})
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				group = sri_custom_lsp_start,
				pattern = { "*.arx" },
				callback = function()
					vim.lsp.start({
						name = "arex",
						cmd = { "/usr/bin/arexlsp" },
						root_dir = "/src",
					})
				end,
			})
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				group = sri_custom_lsp_start,
				pattern = { "*.py" },
				callback = function()
					vim.lsp.start({
						name = "ar-pylint-ls",
						cmd = { "/home/sridharn/bin/artoolslsp/ar-pylint-ls" },
						root_dir = "/src",
						settings = { debug = false },
					})
				end,
			})
			vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
				group = sri_custom_lsp_start,
				pattern = "/src/**",
				callback = function()
					vim.lsp.start({
						name = "ar-formatdiff-ls",
						cmd = { "/home/sridharn/bin/artoolslsp/ar-formatdiff-ls" },
						root_dir = "/src",
						settings = { debug = false },
						on_attach = function()
							vim.keymap.set("n", "<leader>cf", function()
								vim.lsp.buf.format({ timeout_ms = 5000 })
							end, { desc = "LSP: " .. "[C]ode [F]ormat" })
						end,
					})
				end,
			})

			vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
				group = sri_custom_lsp_start,
				pattern = "/src/**",
				callback = function()
					vim.lsp.start({
						name = "ar-grok-ls",
						cmd = { "/home/sridharn/bin/artoolslsp/ar-grok-ls" },
						root_dir = "/src",
						settings = { debug = false },
					})
				end,
			})
		end,
	},
}
