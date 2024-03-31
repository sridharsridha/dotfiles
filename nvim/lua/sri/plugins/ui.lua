return {
	{ "nvim-tree/nvim-web-devicons", lazy = false },

	{
		"echasnovski/mini.tabline",
		opts = {},
	},

	{
		"echasnovski/mini.statusline",
		opts = {},
	},

	{
		"echasnovski/mini.indentscope",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		opts = function(_, opts)
			opts.options = { try_as_border = true }
			opts.draw = {
				delay = 0,
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
	-- -- -- Visually display indent levels
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	event = { "BufRead", "BufWinEnter", "BufNewFile" },
	-- 	keys = {
	-- 		{ "<Leader>ue", "<cmd>IBLToggle<CR>", desc = "Toggle indent-lines" },
	-- 	},
	-- 	opts = {
	-- 		indent = {
	-- 			-- See more characters at :h ibl.config.indent.char
	-- 			char = "│", -- ▏│
	-- 			tab_char = "│",
	-- 			-- priority = 100, -- Display over folded lines
	-- 		},
	-- 		scope = { enabled = false },
	-- 		exclude = {
	-- 			filetypes = {
	-- 				"alpha",
	-- 				"checkhealth",
	-- 				"dashboard",
	-- 				"git",
	-- 				"gitcommit",
	-- 				"help",
	-- 				"lazy",
	-- 				"lazyterm",
	-- 				"lspinfo",
	-- 				"man",
	-- 				"mason",
	-- 				"neo-tree",
	-- 				"notify",
	-- 				"Outline",
	-- 				"TelescopePrompt",
	-- 				"TelescopeResults",
	-- 				"terminal",
	-- 				"toggleterm",
	-- 				"Trouble",
	-- 			},
	-- 		},
	-- 	},
	-- },

	-- {
	-- 	"johnfrankmorgan/whitespace.nvim",
	-- 	opts = {
	-- 		-- `ignored_filetypes` configures which filetypes to ignore when
	-- 		-- displaying trailing whitespace
	-- 		ignored_filetypes = {
	-- 			"TelescopePrompt",
	-- 			"lazy",
	-- 			"Trouble",
	-- 			"help",
	-- 			"toggleterm",
	-- 			"log",
	-- 			"nofile",
	-- 			"lspinfo",
	-- 			"lazyterm",
	-- 			"man",
	-- 			"mason",
	-- 			"Outline",
	-- 		},
	-- 	},
	-- },

	-- Highlight words quickly
	{
		"t9md/vim-quickhl",
		keys = {
			{
				"<leader>mt",
				"<Plug>(quickhl-manual-this)",
				mode = { "n", "x" },
				desc = "Highlight word",
			},
		},
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
				split = "sv",
				vsplit = "sg",

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

	-- Super powerful color picker/colorizer plugin
	{
		"uga-rosa/ccc.nvim",
		ft = { "tmux", "markdown", "lua" },
		event = "FileType",
		keys = {
			{ "<Leader>mc", "<cmd>CccPick<CR>", desc = "Color-picker" },
		},
		opts = {
			highlighter = {
				auto_enable = true,
				lsp = true,
				excludes = { "lazy", "mason", "help", "neo-tree" },
			},
		},
	},
	{
		"kevinhwang91/nvim-hlslens",
		opts = {
			calm_down = true,
		},
		keys = {
			-- FYI: debug mapping with `:map ...`
			{
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				noremap = true,
				silent = true,
				desc = "Next Match",
			},
			{
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				noremap = true,
				silent = true,
				desc = "Previous Match",
			},

			-- TODO: Respect smartcase with:
			--  https://github.com/olimorris/dotfiles-1/blob/0a3168e068e21fd9f51be27fe7bdb72ef2643d88/.config/nvim/lua/plugins/hlslens.lua#L11-L31
			{ "*", [[*<Cmd>lua require('hlslens').start()<CR>]], noremap = true, silent = true, desc = "Match Word" },
			{ "#", [[#<Cmd>lua require('hlslens').start()<CR>]], noremap = true, silent = true, desc = "Match Word" },
			{ "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], noremap = true, silent = true, desc = "Match Word" },
			{ "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], noremap = true, silent = true, desc = "Match Word" },
		},
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		config = true,
		event = { "WinNew" },
	},
	{
		"jinh0/eyeliner.nvim",
		opts = {
			highlight_on_key = true, -- show highlights only after keypress
			dim = false, -- dim all other characters if set to true (recommended!)
		},
	},
	{
		"max397574/better-escape.nvim",
		opts = {
			mapping = { "jk", "kj" },
			keys = function()
				return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
			end,
		},
	},
	{
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
		event = "CmdlineEnter",
	},
	{ "winston0410/range-highlight.nvim", dependencies = { "winston0410/cmd-parser.nvim" }, config = true },
	{ "Aasim-A/scrollEOF.nvim", config = false },
	{
		"kawre/neotab.nvim",
		event = "InsertEnter",
		opts = {
			-- FYI: getting tab to work requires extra configuration
			tabkey = "<C-f>",
			-- act_as_tab = false, -- Having this produce a tab might be a useful side-effect
			smart_punctuators = {
				enabled = false,
			},
		},
	},
	{
		"AckslD/muren.nvim",
		event = "VeryLazy",
		config = true,
	},
}
