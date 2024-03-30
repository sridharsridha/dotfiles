return {
	-- Lua fork of vim-devicons
	{ "nvim-tree/nvim-web-devicons", lazy = false },
	{
		"echasnovski/mini.tabline",
		opts = {},
	},
	{
		"echasnovski/mini.statusline",
		opts = {},
	},
	-- Active indent guide and indent text objects. When you're browsing
	-- code, this highlights the current level of indentation, and animates
	-- the highlighting.
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

	{
		"johnfrankmorgan/whitespace.nvim",
		opts = {
			-- `ignored_filetypes` configures which filetypes to ignore when
			-- displaying trailing whitespace
			ignored_filetypes = {
				"TelescopePrompt",
				"lazy",
				"Trouble",
				"help",
				"toggleterm",
				"log",
				"nofile",
				"lspinfo",
				"lazyterm",
				"man",
				"mason",
				"Outline",
			},
		},
	},
	-- -- Visually display indent levels
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
	-- 	-- Highlight words quickly
	{
		"t9md/vim-quickhl",
		keys = {
			{
				"<Leader>mt",
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
	-- Interacting with and manipulating marks
	{
		"chentoast/marks.nvim",
		dependencies = "lewis6991/gitsigns.nvim",
		event = "FileType",
		keys = {
			{ "m/", "<cmd>MarksListAll<CR>", desc = "Marks from all opened buffers" },
		},
		opts = {
			sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
			bookmark_1 = { sign = "󰈼" }, -- ⚐ ⚑ 󰈻 󰈼 󰈽 󰈾 󰈿 󰉀
			mappings = {
				annotate = "m<Space>",
			},
		},
	},
	-- {
	-- 	"LunarVim/breadcrumbs.nvim",
	-- 	dependencies = {
	-- 		{ "SmiteshP/nvim-navic" },
	-- 	},
	-- 	config = function()
	-- 		require("nvim-navic").setup({
	-- 			lsp = {
	-- 				auto_attach = true,
	-- 			},
	-- 		})
	--
	-- 		require("breadcrumbs").setup()
	-- 	end,
	-- },
}
