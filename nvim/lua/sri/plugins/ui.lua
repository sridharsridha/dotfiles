return {
	{ "nvim-tree/nvim-web-devicons", lazy = false },

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
	-- {
	-- 	"t9md/vim-quickhl",
	-- 	keys = {
	-- 		{
	-- 			"<leader>mt",
	-- 			"<Plug>(quickhl-manual-this)",
	-- 			mode = { "n", "x" },
	-- 			desc = "Highlight word",
	-- 		},
	-- 	},
	-- },

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
	-- {
	-- 	"uga-rosa/ccc.nvim",
	-- 	event = "FileType",
	-- 	keys = {
	-- 		{ "<Leader>mc", "<cmd>CccPick<CR>", desc = "Color-picker" },
	-- 	},
	-- 	opts = {
	-- 		highlighter = {
	-- 			auto_enable = true,
	-- 			lsp = true,
	-- 			excludes = { "lazy", "mason", "help", "neo-tree" },
	-- 		},
	-- 	},
	-- },

	-- Disable cursorline when moving, for various perf reasons
	-- {
	-- 	"yamatsum/nvim-cursorline", -- replaces delphinus/auto-cursorline.nvim",
	-- 	config = function()
	-- 		require("nvim-cursorline").setup({
	-- 			cursorline = {
	-- 				enable = true,
	-- 				timeout = 300,
	-- 				number = false,
	-- 			},
	-- 			cursorword = {
	-- 				-- known issue https://github.com/yamatsum/nvim-cursorline/issues/27
	-- 				-- but i don't use netrw, so maybe non-issue
	-- 				enable = true,
	-- 				min_length = 3,
	-- 				hl = { underline = true },
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
