return {
	{ "echasnovski/mini.tabline", opts = {} },
	{ "echasnovski/mini.statusline", opts = { use_icons = false } },
	{
		"echasnovski/mini.indentscope",
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

	-- {
	--    "kevinhwang91/nvim-hlslens",
	--    opts = {
	--       calm_down = true,
	--    },
	--    keys = {
	--       -- FYI: debug mapping with `:map ...`
	--       {
	--          "n",
	--          [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
	--          noremap = true,
	--          silent = true,
	--          desc = "Next Match",
	--       },
	--       {
	--          "N",
	--          [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
	--          noremap = true,
	--          silent = true,
	--          desc = "Previous Match",
	--       },
	--
	--       -- TODO: Respect smartcase with:
	--       --  https://github.com/olimorris/dotfiles-1/blob/0a3168e068e21fd9f51be27fe7bdb72ef2643d88/.config/nvim/lua/plugins/hlslens.lua#L11-L31
	--       { "*",  [[*<Cmd>lua require('hlslens').start()<CR>]],  noremap = true, silent = true, desc = "Match Word" },
	--       { "#",  [[#<Cmd>lua require('hlslens').start()<CR>]],  noremap = true, silent = true, desc = "Match Word" },
	--       { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], noremap = true, silent = true, desc = "Match Word" },
	--       { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], noremap = true, silent = true, desc = "Match Word" },
	--    },
	-- },

	{
		"max397574/better-escape.nvim",
		opts = {
			timeout = vim.o.timeoutlen,
			default_mappings = true,
		},
	},

	{
		"nacro90/numb.nvim",
		event = { "CmdlineEnter" },
		config = function()
			require("numb").setup()
		end,
	},

	{
		"kawre/neotab.nvim",
		event = "InsertEnter",
		opts = {},
	},

	-- search/replace in multiple files
	{
		"MagicDuck/grug-far.nvim",
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

	-- Flash enhances the built-in search functionality by showing labels
	-- at the end of each match, letting you quickly jump to a specific
	-- location.
	{
		"folke/flash.nvim",
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

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
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
		cmd = { "TodoTrouble", "TodoTelescoppackagee" },
		opts = {},
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
	{ "aserowy/tmux.nvim", opts = {} },
}
