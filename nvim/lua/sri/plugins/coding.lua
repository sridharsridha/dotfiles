return {
   {
      -- "altermo/ultimate-autopair.nvim",
      "windwp/nvim-autopairs",
      event = { "InsertEnter", "CmdlineEnter" },
      opts = {
         disable_filetype = { "TelescopePrompt" },
      },
   },

   {
      "echasnovski/mini.surround",
      event = "InsertEnter",
      opts = {
         -- Module mappings. Use `''` (empty string) to disable one.
         mappings = {
            add = "sa",            -- Add surrounding in Normal and Visual modes
            delete = "sd",         -- Delete surrounding
            replace = "sr",        -- Replace surrounding
            find = "sf",           -- Find surrounding (to the right)
            find_left = "sF",      -- Find surrounding (to the left)
            highlight = "sh",      -- Highlight surrounding
            update_n_lines = "sn", -- Update `n_lines`

            suffix_last = "l",     -- Suffix to search with "prev" method
            suffix_next = "n",     -- Suffix to search with "next" method
         },
      },
   },

   {
      -- Split and join arguments
      "echasnovski/mini.splitjoin",
      enabled = false,
      event = "InsertEnter",
      opts = {
         mappings = {
            toggle = "gS",
            split = "",
            join = "",
         },
      },
   },

   -- Code jump
   {
      "rgroli/other.nvim",
      cmd = { "Other", "OtherSplit", "OtherVSplit" },
      keys = {
         { "<leader>oo", "<cmd>:Other<CR>",       desc = "Other file" },
         { "<leader>os", "<cmd>:OtherSplit<CR>",  desc = "Other file split" },
         { "<leader>ov", "<cmd>:OtherVSplit<CR>", desc = "Other file vsplit" },
      },
      config = function()
         require("other-nvim").setup({
            showMissingFiles = false,
            keybindings = {
               ["<cr>"] = "open_file_by_command()", -- Open the file with last opening command based on how the filepicker was initially opened. (Other, OtherTab, OtherSplit, OtherVSplit)
               ["<esc>"] = "close_window()",
               o = "open_file()",
               q = "close_window()",
               v = "open_file_vs()",  -- open file in a vertical split
               s = "open_file_sp()",  -- open file in a horizontal split
               sv = "open_file_vs()", -- open file in a vertical split
               sh = "open_file_sp()", -- open file in a horizontal split
            },
            mappings = {
               -- custom mapping
               {
                  pattern = "/src/(.*)/(.*).tau$",
                  target = "/src/%1/ArmPlugin/%2Util.tau",
                  component = "Util",
               },
               {
                  pattern = "/src/(.*)/ArmPlugin/(.*)Util.tau$",
                  target = "/src/%1/%2.tau",
                  component = "SwTable",
               },
               {
                  pattern = "(.*).h$",
                  target = "%1.cpp",
                  component = "cpp",
               },
               {
                  pattern = "(.*).cpp$",
                  target = "%1.h",
                  component = "h",
               },
               {
                  pattern = "(.*).tac$",
                  target = {
                     {
                        target = "%1.tin",
                        component = "tin",
                     },
                     {
                        target = "%1.itin",
                        component = "itin",
                     },
                  },
               },
               {
                  pattern = "(.*).tin$",
                  target = {
                     {
                        target = "%1.tac",
                        component = "tac",
                     },
                     {
                        target = "%1.itin",
                        component = "itin",
                     },
                  },
               },
               {
                  pattern = "(.*).itin$",
                  target = {
                     {
                        target = "%1.tac",
                        component = "tac",
                     },
                     {
                        target = "%1.tin",
                        component = "tin",
                     },
                  },
               },
            },
         })
      end,
   },

   { "axelf4/vim-strip-trailing-whitespace", enabled = false },
   {
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      "echasnovski/mini.ai",
      enabled = false,
      event = { "InsertEnter" },
      opts = function()
         local ai = require("mini.ai")
         return {
            n_lines = 500,
            custom_textobjects = {
               o = ai.gen_spec.treesitter({
                  a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                  i = { "@block.inner", "@conditional.inner", "@loop.inner" },
               }, {}),
               f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
               c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
               t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
            },
         }
      end,
      config = function(_, opts)
         require("mini.ai").setup(opts)
      end,
   },

   {
      "folke/ts-comments.nvim",
      event = "VeryLazy",
      opts = {},
   },

}
