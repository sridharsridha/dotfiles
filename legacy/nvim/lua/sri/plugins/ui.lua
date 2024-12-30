return {
	{ "echasnovski/mini.tabline", opts = {}, enabled = false },
	{ "echasnovski/mini.statusline", opts = { use_icons = false }, enabled = true },
	{
		"echasnovski/mini.indentscope",
		enabled = false,
		event = "BufReadPre",
		opts = function(_, opts)
			opts.draw = {
				animation = require("mini.indentscope").gen_animation.none(),
			}
		end,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"alpha",
					"dashboard",
					"help",
					"lazy",
					"lazyterm",
					"man",
					"mason",
					"neo-tree",
					"notify",
					"Outline",
					"toggleterm",
					"Trouble",
					"lspinfo",
				},
				callback = function()
					vim.b["miniindentscope_disable"] = true
				end,
			})
		end,
	},
	-- Better quickfix window in Neovim
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		cmd = "BqfAutoToggle",
		event = "QuickFixCmdPost",
		opts = {
			auto_resize_height = false,
			func_map = {
				tab = "st",
				split = "sh",
				vsplit = "sv",

				stoggleup = "K",
				stoggledown = "J",

				ptoggleitem = "p",
				ptoggleauto = "P",
				ptogglemode = "zp",

				pscrollup = "<C-b>",
				pscrolldown = "<C-f>",

				prevfile = "gk",
				nextfile = "gj",

				prevhist = "<S-Tab>",
				nexthist = "<Tab>",
			},
			preview = {
				auto_preview = true,
				should_preview_cb = function(bufnr)
					-- file size greater than 100kb can't be previewed automatically
					local filename = vim.api.nvim_buf_get_name(bufnr)
					local fsize = vim.fn.getfsize(filename)
					if fsize > 100 * 1024 then
						return false
					end
					return true
				end,
			},
		},
	},

	{
		"yorickpeterse/nvim-pqf",
		ft = "qf",
		event = "QuickFixCmdPost",
		config = function()
			require("pqf").setup({
				signs = {
					error = { text = "", hl = "DiagnosticSignError" },
					warning = { text = "", hl = "DiagnosticSignWarn" },
					info = { text = "", hl = "DiagnosticSignInfo" },
					-- hint = { text = '󰌵', hl = 'DiagnosticSignHint' },
				},
			})
		end,
	},

	{
		"max397574/better-escape.nvim",
		enabled = false,
		opts = {
			timeout = vim.o.timeoutlen,
			default_mappings = true,
		},
	},

	{
		"nacro90/numb.nvim",
		enabled = false,
		event = { "CmdlineEnter" },
		config = function()
			require("numb").setup()
		end,
	},

	{
		"kawre/neotab.nvim",
		enabled = false,
		event = "InsertEnter",
		opts = {},
	},

	-- search/replace in multiple files
	{
		"MagicDuck/grug-far.nvim",
		enabled = false,
		opts = { headerMaxWidth = 80 },
		cmd = "GrugFar",
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.grug_far({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
	},

	-- -- Flash enhances the built-in search functionality by showing labels
	-- -- at the end of each match, letting you quickly jump to a specific
	-- -- location.
	{
		"folke/flash.nvim",
		enabled = false,
		event = "VeryLazy",
		vscode = true,
		opts = {},
	     -- stylua: ignore
	     keys = {
	        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
	        { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
	        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
	        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
	     },
	},

	-- file explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
		cmd = "Neotree",
		dependencies = {
			{ "MunifTanjim/nui.nvim", lazy = true },
		},
		keys = {
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{
				"<leader>ge",
				function()
					require("neo-tree.command").execute({ source = "git_status", toggle = true })
				end,
				desc = "Git Explorer",
			},
			{
				"<leader>be",
				function()
					require("neo-tree.command").execute({ source = "buffers", toggle = true })
				end,
				desc = "Buffer Explorer",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
			-- because `cwd` is not set up properly.
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
				desc = "Start Neo-tree with directory",
				once = true,
				callback = function()
					if package.loaded["neo-tree"] then
						return
					else
						local stats = vim.uv.fs_stat(vim.fn.argv(0))
						if stats and stats.type == "directory" then
							require("neo-tree")
						end
					end
				end,
			})
		end,
		opts = {
			sources = { "filesystem", "buffers", "git_status" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					["<space>"] = "none",
					["Y"] = {
						function(state)
							local node = state.tree:get_node()
							local path = node:get_id()
							vim.fn.setreg("+", path, "c")
						end,
						desc = "Copy Path to Clipboard",
					},
					["O"] = {
						function(state)
							require("lazy.util").open(state.tree:get_node().path, { system = true })
						end,
						desc = "Open with System Application",
					},
					["P"] = { "toggle_preview", config = { use_float = false } },
				},
			},
		},
	},

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		enabled = false,
		cmd = { "Trouble" },
		opts = {
			modes = {
				lsp = {
					win = { position = "right" },
				},
			},
		},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>cS",
				"<cmd>Trouble lsp toggle<cr>",
				desc = "LSP references/definitions/... (Trouble)",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},

	-- Finds and lists all of the TODO, HACK, BUG, etc comment
	-- in your project and loads them into a browsable list.
	{
		"folke/todo-comments.nvim",
		enabled = false,
		cmd = { "TodoTrouble", "TodoTelescoppackagee" },
		opts = { signs = false },
      -- stylua: ignore
      keys = {
         { "]t",         function() require("todo-comments").jump_next() end,              desc = "Next Todo Comment" },
         { "[t",         function() require("todo-comments").jump_prev() end,              desc = "Previous Todo Comment" },
         { "<leader>xt", "<cmd>Trouble todo toggle<cr>",                                   desc = "Todo (Trouble)" },
         { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
         { "<leader>st", "<cmd>TodoTelescope<cr>",                                         desc = "Todo" },
         { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",                 desc = "Todo/Fix/Fixme" },
      },
	},

	-- Tmux integration.
	{
		"aserowy/tmux.nvim",
		opts = {
			copy_sync = {
				-- enables copy sync. by default, all registers are synchronized.
				-- to control which registers are synced, see the `sync_*` options.
				enable = true,
			},
		},
		enabled = true,
	},
}
