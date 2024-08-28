return {
   { "MTDL9/vim-log-highlighting", ft = "log" },
   {
      "nvim-treesitter/nvim-treesitter",
      event = { "BufReadPost", "BufNewFile" },
      cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
      build = ":TSUpdate",
      dependencies = {
         {
            "nvim-treesitter/nvim-treesitter-textobjects",
         },
      },
      init = function(plugin)
         -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
         -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
         -- no longer trigger the **nvim-treeitter** module to be loaded in time.
         -- Luckily, the only thins that those plugins need are the custom queries, which we make available
         -- during startup.
         -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
         require("lazy.core.loader").add_to_rtp(plugin)
         require("nvim-treesitter.query_predicates")
      end,
      config = function()
         local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
         parser_config.tac = {
            install_info = {
               url = "~/tree-sitter-tac",
               files = { "src/scanner.cc", "src/parser.c" },
               generate_requires_npm = false, -- if stand-alone parser without npm dependencies
               requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
            },
            filetype = "tac",
         }
         require("nvim-treesitter.configs").setup({
            ensure_installed = {
               "bash",
               "c",
               "lua",
               "markdown",
               "vim",
               "vimdoc",
               "python",
               "json",
               "yaml",
               "tmux",
               "cpp",
            },
            auto_install = false,
            highlight = {
               enable = true,
               disable = function(_, bufnr)
                  return vim.b[bufnr].large_buf
               end,
            },
            indent = { enable = true },
            refactor = {
               highlight_definitions = { enable = true },
               highlight_current_scope = { enable = true },
            },
            -- incremental_selection = {
            -- 	enable = true,
            -- 	keymaps = {
            -- 		init_selection = "<leader>I",
            -- 		scope_incremental = "<leader>I",
            -- 		node_incremental = "<leader>I",
            -- 		node_decremental = "<leader>D",
            -- 	},
            -- },
            textobjects = {
               select = {
                  enable = true,
                  lookahead = true,
                  keymaps = {
                     -- You can use the capture groups defined in textobjects.scm
                     ["ak"] = { query = "@block.outer", desc = "around block" },
                     ["ik"] = { query = "@block.inner", desc = "inside block" },
                     ["ac"] = { query = "@class.outer", desc = "around class" },
                     ["ic"] = { query = "@class.inner", desc = "inside class" },
                     ["a?"] = { query = "@conditional.outer", desc = "around conditional" },
                     ["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
                     ["af"] = { query = "@function.outer", desc = "around function " },
                     ["if"] = { query = "@function.inner", desc = "inside function " },
                     ["ao"] = { query = "@loop.outer", desc = "around loop" },
                     ["io"] = { query = "@loop.inner", desc = "inside loop" },
                     ["aa"] = { query = "@parameter.outer", desc = "around argument" },
                     ["ii"] = { query = "@parameter.inner", desc = "inside argument" },
                  },
               },
               move = {
                  enable = true,
                  set_jumps = true,
                  goto_next_start = {
                     ["]k"] = { query = "@block.outer", desc = "Next block start" },
                     ["]f"] = { query = "@function.outer", desc = "Next function start" },
                     ["]c"] = { query = "@class.outer", desc = "Next class start" },
                     ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
                  },
                  goto_next_end = {
                     ["]K"] = { query = "@block.outer", desc = "Next block end" },
                     ["]F"] = { query = "@function.outer", desc = "Next function end" },
                     ["]C"] = { query = "@class.outer", desc = "Next class end" },
                     ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
                  },
                  goto_previous_start = {
                     ["[k"] = { query = "@block.outer", desc = "Previous block start" },
                     ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                     ["[c"] = { query = "@class.outer", desc = "Previous class start" },
                     ["[a"] = { query = "@parameter.inner", desc = "Previous argument start" },
                  },
                  goto_previous_end = {
                     ["[K"] = { query = "@block.outer", desc = "Previous block end" },
                     ["[F"] = { query = "@function.outer", desc = "Previous function end" },
                     ["[C"] = { query = "@class.outer", desc = "Previous class end" },
                     ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
                  },
               },
               swap = {
                  enable = true,
                  swap_next = {
                     [">K"] = { query = "@block.outer", desc = "Swap next block" },
                     [">F"] = { query = "@function.outer", desc = "Swap next function" },
                     [">A"] = { query = "@parameter.inner", desc = "Swap next argument" },
                  },
                  swap_previous = {
                     ["<K"] = { query = "@block.outer", desc = "Swap previous block" },
                     ["<F"] = { query = "@function.outer", desc = "Swap previous function" },
                     ["<A"] = { query = "@parameter.inner", desc = "Swap previous argument" },
                  },
               },
            },
         })
      end,
   },

   {
      "nvim-treesitter/nvim-treesitter-context",
      event = { "BufRead" },
      config = function()
         require("treesitter-context").setup({
            mode = "cursor",
            max_lines = 3,
         })
      end,
   },
}
