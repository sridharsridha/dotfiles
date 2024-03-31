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
		-- 	     Old text               Command            New text
		--     surr*ound_words             ysiw)           (surround_words)
		--     *make strings               ys$"            "make strings"
		--     [delete ar*ound me!]        ds]             delete around me!
		--     remove <b>HTML t*ags</b>    dst             remove HTML tags
		--     'change quot*es'            cs'"            "change quotes"
		--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
		--     delete(functi*on calls)     dsf             function calls
		"kylechui/nvim-surround",
		event = "InsertEnter",
		opts = {},
	},

	{
		-- Fast and familiar per-line commenting
		"echasnovski/mini.comment",
		event = { "InsertEnter" },
		keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
		opts = {},
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
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		keys = {
			{
				"<leader>cj",
				"<cmd>lua MiniSplitjoin.join()<CR>",
				mode = { "n", "x" },
				desc = "Join arguments",
			},
			{
				"<leader>ck",
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
