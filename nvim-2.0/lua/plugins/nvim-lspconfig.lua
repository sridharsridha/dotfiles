return {

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"j-hui/fidget.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			servers = {
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
							},
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							diagnostics = { globals = { "vim" }, disable = { "missing-fields" } },
						},
					},
				},
            -- basedpyright = {},
			},
			diagnostics = {
				underline = true,
				update_in_insert = true,
				virtual_text = {
					spacing = 4,
					source = "if_many",
				},
				severity_sort = true,
			},
			inlay_hints = { enabled = true },
		},
		config = function(_, opts)
			-- Only setup ar-grok-ls if executable exists
			if vim.fn.executable("/home/sridharn/bin/artoolslsp/ar-grok-ls") == 1 then
				vim.lsp.config("argrok", {
					cmd = { "/home/sridharn/bin/artoolslsp/ar-grok-ls" },
					root_dir = function(_)
						return "/src"
					end,
					settings = { debug = false },
				})
				vim.lsp.enable("argrok")
			end

			-- Only setup ar-formatdiff-ls if executable exists
			if vim.fn.executable("/home/sridharn/bin/artoolslsp/ar-formatdiff-ls") == 1 then
				vim.lsp.config("arformatdiff", {
					cmd = { "/home/sridharn/bin/artoolslsp/ar-formatdiff-ls" },
					root_dir = function(_)
						return "/src"
					end,
					settings = { debug = false },
				})
				vim.lsp.enable("arformatdiff")
			end

			-- Only setup ar-pylint-ls if executable exists
			if vim.fn.executable("/home/sridharn/bin/artoolslsp/ar-pylint-ls") == 1 then
				vim.lsp.config("arpylint", {
					cmd = { "/home/sridharn/bin/artoolslsp/ar-pylint-ls" },
					root_dir = function(_)
						return "/src"
					end,
					settings = { debug = false },
					filetypes = { "python" },
				})
				vim.lsp.enable("arpylint")
			end

			-- Only setup arexlsp if executable exists
			if vim.fn.executable("/usr/bin/arexlsp") == 1 then
				vim.lsp.config("arex", {
					cmd = { "/usr/bin/arexlsp" },
					root_dir = function(_)
						return "/src"
					end,
					filetypes = { "arx" },
				})
				vim.lsp.enable("arex")
			end

			-- Only setup artaclsp if executable exists
			if vim.fn.executable("/usr/bin/artaclsp") == 1 then
				vim.lsp.config("tacc", {
					cmd = { "/usr/bin/artaclsp", "-I", "/bld/" },
					root_dir = function(_)
						return "/src"
					end,
					filetypes = { "tac" },
				})
				vim.lsp.enable("tacc")
			end

			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				vim.lsp.enable(server, config)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("sri-lsp-attach", { clear = true }),
				callback = function(event)
					local map = vim.keymap.set
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

					map("n", "<leader>cd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Go to Definition" })
					map("n", "<leader>cD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "Go to Declaration" })
					map("n", "<leader>ch", vim.lsp.buf.hover, { buffer = event.buf, desc = "Hover" })
					map(
						"n",
						"<leader>ci",
						vim.lsp.buf.implementation,
						{ buffer = event.buf, desc = "Go to Implementation" }
					)
					map("n", "<leader>cs", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "Signature Help" })
					map(
						"n",
						"<leader>cwa",
						vim.lsp.buf.add_workspace_folder,
						{ buffer = event.buf, desc = "Add Workspace Folder" }
					)
					map(
						"n",
						"<leader>cwr",
						vim.lsp.buf.remove_workspace_folder,
						{ buffer = event.buf, desc = "Remove Workspace Folder" }
					)
					map("n", "<leader>cwl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, { buffer = event.buf, desc = "List Workspace Folders" })
					map(
						"n",
						"<leader>ct",
						vim.lsp.buf.type_definition,
						{ buffer = event.buf, desc = "Go to Type Definition" }
					)
					map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })
					map(
						{ "n", "v" },
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ buffer = event.buf, desc = "Code Action" }
					)
					map("n", "<leader>cf", function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = event.buf, desc = "Format" })
				end,
			})
		end,
	},
}
