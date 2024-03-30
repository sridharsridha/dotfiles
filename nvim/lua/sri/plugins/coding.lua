return {
	{
		-- Powerful auto-pair plugin with multiple characters support
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
		},
	},

	{
		-- Fast and feature-rich surround actions
		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		"echasnovski/mini.surround",
	},

	{
		-- Set the commentstring based on the cursor location
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable = true,
			enable_autocmd = false,
		},
	},

	{
		-- Fast and familiar per-line commenting
		"echasnovski/mini.comment",
		event = { "InsertEnter" },
		keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},

	{
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		"echasnovski/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				-- stylua: ignore
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { '@block.outer', '@conditional.outer', '@loop.outer' },
						i = { '@block.inner', '@conditional.inner', '@loop.inner' },
					}, {}),
					f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
					c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
					t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
		end,
	},

	{
		-- Split and join arguments
		"echasnovski/mini.splitjoin",
		keys = {
			{
				"sj",
				"<cmd>lua MiniSplitjoin.join()<CR>",
				mode = { "n", "x" },
				desc = "Join arguments",
			},
			{
				"sk",
				"<cmd>lua MiniSplitjoin.split()<CR>",
				mode = { "n", "x" },
				desc = "Split arguments",
			},
		},
		opts = {
			mappings = { toggle = "" },
		},
	},

	{
		"axelf4/vim-strip-trailing-whitespace",
	},
}
