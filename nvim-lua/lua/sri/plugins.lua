local fn = vim.fn
local api = vim.api

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = api.nvim_create_augroup('Packer_Custom', { clear = true })
api.nvim_create_autocmd('BufWritePost', {
	command = 'source <afile> | PackerCompile',
	group = packer_group,
	pattern = 'plugins.lua',
})

local VeryLazy = { "BufNewFile", "BufRead" }

return require('packer').startup(function(use)
	-- Let packer manage itself
	use('wbthomason/packer.nvim')
	use('lewis6991/impatient.nvim')
	use({ "nvim-lua/plenary.nvim", module = "plenary" })
	use({
		'kyazdani42/nvim-web-devicons',
		config = function()
			require('nvim-web-devicons').setup({ default = true })
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			{ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
			{ "p00f/nvim-ts-rainbow", after = "nvim-treesitter",
				config = function()
					require 'nvim-treesitter.configs'.setup {
						rainbow = {
							enable = true,
							extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
							max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
							-- colors = {}, -- table of hex strings
							-- termcolors = {} -- table of colour name strings
						}
					}
				end, },
			{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true, },
				indent = { enable = true, },
				sync_install = true,
				auto_install = true,
			})
		end,
		run = ':TSUpdate'
	})

	use({
		'nvim-tree/nvim-tree.lua',
		requires = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			local ok, nvim_tree = pcall(require, "nvim-tree")
			if not ok then
				return
			end
			nvim_tree.setup({
				view = {
					width = 35,
					hide_root_folder = false,
					side = 'right',
					signcolumn = 'no',
					mappings = {
						custom_only = true, -- `custom_only = false` will merge list of mappings with defaults
						list = {
							{ key = '<C-R>', action = 'refresh' },
							{ key = 'a', action = 'create' },
							{ key = 'd', action = 'remove' },
							{ key = 'h', action = 'close_node' },
							{ key = 'I', action = 'toggle_ignored' },
							{ key = 'l', action = 'edit' },
							{ key = 'r', action = 'rename' },
							{ key = 's', action = 'split' },
							{ key = 'v', action = 'vsplit' },
							{ key = 'Y', action = 'copy_path' },
							{ key = 'y', action = 'copy_name' },
						},
					},
				},
			})
			vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
		end,
	})

	use({
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'williamboman/mason.nvim' },
			-- Autocompletion
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/nvim-cmp' },
			{
				"tzachar/cmp-tabnine",
				run = "./install.sh",
			},
			{ "ray-x/lsp_signature.nvim" },
			{ 'saadparwaiz1/cmp_luasnip' },
			-- Snippets
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },
		},
		config = function()
			local ok, lsp = pcall(require, 'lsp-zero')
			if not ok then
				return
			end
			lsp.preset("recommended")
			lsp.nvim_workspace()
			-- Fix Undefined global 'vim'
			lsp.configure('sumneko_lua', {
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						}
					}
				}
			})
			local cmp = require('cmp')
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local cmp_mappings = lsp.defaults.cmp_mappings({
				['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
				['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
				['<C-y>'] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			})
			lsp.setup_nvim_cmp({
				mapping = cmp_mappings
			})
			lsp.on_attach(function(client, bufnr)
				-- https://github.com/ray-x/lsp_signature.nvim#full-configuration-with-default-values
				require('lsp_signature').on_attach({
					bind = true, -- This is mandatory, otherwise border config won't get registered.
					floating_window = true,
					handler_opts = {
						border = "single"
					},
					zindex = 99, -- <100 so that it does not hide completion popup.
					fix_pos = false, -- Let signature window change its position when needed, see GH-53
					toggle_key = '<M-x>', -- Press <Alt-x> to toggle signature on and off.
				})
				local opts = { buffer = bufnr, remap = false }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
				vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
			end)
			lsp.setup()
			vim.diagnostic.config({
				virtual_text = true,
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					vim.diagnostic.config({
						signs = { priority = 9 },
						virtual_text = { prefix = "▎" },
						float = { header = { "Diagnostics", "Title" }, border = "rounded" },
						update_in_insert = true,
						severity_sort = true,
					})

					local ref_floating_preview = vim.lsp.util.open_floating_preview

					vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
						opts = opts or {}
						opts.border = "rounded"

						return ref_floating_preview(contents, syntax, opts, ...)
					end

					return true
				end,
				once = true,
			})
		end,
	})

	-- Visual keymap help
	use({
		"folke/which-key.nvim",
		config = function()
			require("sri.which-key")
		end,
	})

	-- Colorscheme
	use({
		'ellisonleao/gruvbox.nvim',
		config = function()
			vim.o.background = "dark"
			require("gruvbox").setup()
			vim.api.nvim_cmd({ cmd = 'colorscheme', args = { 'gruvbox' } }, {})
		end,
	})

	-- Show LSP errors/diagnostics in pretty list
	use({
		"folke/trouble.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("trouble").setup {
				position = "bottom", -- position of the list can be: bottom, top, left, right
				height = 10, -- height of the trouble list when position is top or bottom
				width = 50, -- width of the list when position is left or right
				icons = true, -- use devicons for filenames
				mode = "workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
				fold_open = "", -- icon used for open folds
				fold_closed = "", -- icon used for closed folds
				action_keys = { -- key mappings for actions in the trouble list
					-- map to {} to remove a mapping, for example:
					-- close = {},
					close = "q", -- close the list
					cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
					refresh = "r", -- manually refresh
					jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					open_split = { "<c-x>" }, -- open buffer in new split
					open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
					open_tab = { "<c-t>" }, -- open buffer in new tab
					jump_close = { "o" }, -- jump to the diagnostic and close the list
					toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
					toggle_preview = "P", -- toggle auto_preview
					hover = "K", -- opens a small popup with the full multiline message
					preview = "p", -- preview the diagnostic location
					close_folds = { "zM", "zm" }, -- close all folds
					open_folds = { "zR", "zr" }, -- open all folds
					toggle_fold = { "zA", "za" }, -- toggle fold of current file
					previous = "k", -- preview item
					next = "j" -- next item
				},
				indent_lines = true, -- add an indent guide below the fold icons
				auto_open = false, -- automatically open the list when you have diagnostics
				auto_close = false, -- automatically close the list when you have no diagnostics
				auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
				auto_fold = false, -- automatically fold a file trouble list at creation
				signs = {
					-- icons / text used for a diagnostic
					error = "",
					warning = "",
					hint = "",
					information = "",
					other = "﫠"
				},
				use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
			}
		end,
	})

	-- Show LSP TODOs/HACKs in pretty list
	use({
		"folke/todo-comments.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup {
				signs = true, -- show icons in the signs column
				sign_priority = 8, -- sign priority
				-- keywords recognized as todo comments
				keywords = {
					FIX = {
						icon = " ", -- icon used for the sign, and in search results
						color = "error", -- can be a hex color, or a named color (see below)
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
						-- signs = false, -- configure signs for some keywords individually
					},
					TODO = { icon = " ", color = "info" },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				},
				merge_keywords = true, -- when true, custom keywords will be merged with the defaults
				-- highlighting of the line containing the todo comment
				-- * before: highlights before the keyword (typically comment characters)
				-- * keyword: highlights of the keyword
				-- * after: highlights after the keyword (todo text)
				highlight = {
					before = "", -- "fg" or "bg" or empty
					keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
					after = "fg", -- "fg" or "bg" or empty
					pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
					comments_only = true, -- uses treesitter to match keywords in comments only
					max_line_len = 400, -- ignore lines longer than this
					exclude = {}, -- list of file types to exclude highlighting
				},
				-- list of named colors where we try to extract the guifg from the
				-- list of hilight groups or use the hex color if hl not found as a fallback
				colors = {
					error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
					warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
					info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
					hint = { "LspDiagnosticsDefaultHint", "#10B981" },
					default = { "Identifier", "#7C3AED" },
				},
				search = {
					command = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					-- regex that will be used to match keywords.
					-- don't replace the (KEYWORDS) placeholder
					pattern = [[\b(KEYWORDS):]], -- ripgrep regex
					-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
				},
			}
		end,
	})

	use({
		'nvim-lualine/lualine.nvim',
		after = 'gruvbox.nvim',
		event = 'BufEnter',
		require = { 'kyazdani42/nvim-web-devicons', opt = true, },
		config = function()

			require('lualine').setup({
				options = {
					theme = 'gruvbox',
					component_separators = '',
					section_separators = '',
					icons_enabled = true,
					globalstatus = true,
				},
				sections = {
					lualine_a = {
						{ 'mode', color = { gui = 'bold' } },
					},
					lualine_b = {
						{ 'branch' },
						{ 'diff', colored = false },
					},
					lualine_c = {
						{ 'filename', file_status = true },
						{ 'diagnostics' },
					},
					lualine_x = {
						'filetype',
						'encoding',
						'fileformat',
					},
					lualine_y = { 'progress' },
					lualine_z = {
						{ 'location', color = { gui = 'bold' } },
					},
				},
				tabline = {
					lualine_a = {
						{
							'buffers',
							buffers_color = { active = 'lualine_b_normal' },
						},
					},
					lualine_z = {
						{
							'tabs',
							tabs_color = { active = 'lualine_b_normal' },
						},
					},
				},
			})
		end,
	})

	use {
		'lewis6991/gitsigns.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('gitsigns').setup()
		end,
	}
	use({
		"folke/noice.nvim",
		event = "UIEnter",
		requires = {
			{ "MunifTanjim/nui.nvim", module_pattern = "nui.*" },
			{ "rcarriga/nvim-notify", module = "notify" },
		},
		config = function()
			local set_option_value = vim.api.nvim_set_option_value
			local option_opts = {}
			set_option_value("shortmess", vim.api.nvim_get_option_value("shortmess", option_opts) .. "I", option_opts)
			set_option_value("cmdheight", 0, option_opts)
			set_option_value("showcmd", false, option_opts)
			set_option_value("showmode", false, option_opts)
			local hover_opts = { border = { style = "rounded" }, position = { row = 2 } }
			require("noice").setup({
				cmdline = {
					enabled = true, -- enables the Noice cmdline UI
				},
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					progress = { enabled = true, throttle = 40 },
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					hover = { enabled = false, view = "hover", opts = hover_opts },
					signature = { enabled = false, view = "hover", auto_open = { throttle = 40 }, opts = hover_opts },
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false,
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
				views = { split = { size = "25%" }, win_options = { wrap = false }, hover = hover_opts },
			})
			require("notify").setup({ background_colour = "NormalFloat", fps = 24, render = "minimal", timeout = 300 })
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		event = VeryLazy,
		config = function()
			require("indent_blankline").setup({
				use_treesitter = true,
				char = "▏",
				show_current_context = true,
				show_trailing_blankline_indent = false,
				show_first_indent_level = false,
			})
		end,
	})

	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({ check_ts = true })
			require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
		end,
	})
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end
	})
	use({
		"numToStr/Comment.nvim",
		keys = { { "n", "gc" }, { "v", "gc" } },
		config = function() require("Comment").setup() end,
	})
	use({
		"sindrets/diffview.nvim",
		module = "neogit",
		cmd = "Neogit",
	})
	use({
		"TimUntersberger/neogit",
		after = "diffview.nvim",
		config = function()
			require("neogit").setup({
				disable_commit_confirmation = true,
				signs = { section = { "", "" }, item = { "", "" } },
				integrations = { diffview = true },
			})
		end
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
		},
		config = function()
			local ok, telescope = pcall(require, 'telescope')
			if not ok then
				return
			end
			telescope.setup {
				defaults = {
					sorting_strategy = "ascending",
					prompt_prefix = "  ",
					selection_caret = '❯ ',
					layout_config = { horizontal = { preview_width = 0.5 } },
					mappings = {
						i = {
							['<C-j>'] = "move_selection_next",
							['<C-k>'] = "move_selection_previous",
							["<Esc>"] = "close",
						},
						n = { ['<C-c>'] = "close" },
					},

					windowwinblend = 10,
					vimgrep_arguments = {
						"rg",
						"--hidden",
						"--glob=!.git,!.svn,!.hg,!CSV,!.DS_Store,!Thumbs.db,!node_modules,!bower_components,!*.code-search",
						"--ignore-case",
						"--with-filename",
						"--line-number",
						"--column",
						"--no-heading",
						"--trim",
						"--color=never",
					},
				},
			}
			-- local is_git_dir = os.execute 'git rev-parse --is-inside-work-tree >> /dev/null 2>&1'
			-- if is_git_dir == 0 then
			--     vim.keymap.set('n', '<C-p>', '<cmd>lua require"telescope.builtin".git_files()<CR>')
			-- else
			--     vim.keymap.set('n', '<C-p>', '<cmd>lua require"telescope.builtin".find_files()<CR>')
			-- end
			vim.keymap.set('n', '<C-p>', '<cmd>lua require"telescope.builtin".find_files()<CR>')
			vim.keymap.set('n', '<space>fb', '<cmd>Telescope buffers theme=get_dropdown<CR>')
			vim.keymap.set('n', '<space>fh', '<cmd>lua require"telescope.builtin".help_tags()<CR>')
			vim.keymap.set('n', '<space>fo', '<cmd>lua require"telescope.builtin".oldfiles()<CR>')
			vim.keymap.set('n', '<space>fw', '<cmd>lua require"telescope.builtin".live_grep()<CR>')
			vim.keymap.set('n', '<space>fd', '<cmd>lua require"telescope.builtin".git_files({cwd = "$HOME/.dotfiles" })<CR>')
			require("telescope").load_extension("fzf")
		end,
	})
	use { "anuvyklack/windows.nvim",
		requires = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim"
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require('windows').setup()
		end
	}
	use { 'gen740/SmoothCursor.nvim',
		config = function()
			require("smoothcursor").setup({
				cursor = nil,
				texthl = nil,
				fancy = {
					enable = true,
					head = { cursor = nil, texthl = nil, linehl = nil },
					tail = { cursor = nil, texthl = nil, linehl = nil },
				},
				speed = 24,
				intervals = 40,
				priority = 11,
				threshold = 1,
				disabled_filetypes = {
					"aerial",
					"checkhealth",
					"fern",
					"lspinfo",
					"mason",
					"nerdterm",
					"noice",
					"notify",
					"null-ls-info",
					"packer",
					"qf",
					"TelescopePrompt",
				},
			})
		end
	}
	use {
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require('hop').setup({
				quit_key = '<SPC>',
				keys = 'etovxqpdygfblzhckisuran',
				create_hl_autocmd = false,
			})
		end
	}
	use({
		"aserowy/tmux.nvim",
		keys = {
			{ "n", "<C-h>" },
			{ "n", "<C-j>" },
			{ "n", "<C-k>" },
			{ "n", "<C-l>" },
			{ "n", "<A-h>" },
			{ "n", "<A-j>" },
			{ "n", "<A-k>" },
			{ "n", "<A-l>" },
		},
		config = function()
			require("tmux").setup({
				copy_sync = { enable = false },
				navigation = { cycle_navigation = true, enable_default_keybindings = true },
				resize = { enable_default_keybindings = true, resize_step_x = 1, resize_step_y = 1 },
			})
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)
