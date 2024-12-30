return {
   -- Useful plugin to show you pending keybinds.
   {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts_extend = { "spec" },
      opts = {
         preset = "helix",
         win = {
            border = "none",
            padding = { 1, 2 },
         },
         icons = {
            mappings = false,
            rules = false,
            colors = false,
         },
         show_help = false,
         spec = {
            {
               mode = { "n", "v" },
               { "<leader>c",  group = "code" },
               { "<leader>f",  group = "file/find" },
               { "<leader>g",  group = "git" },
               { "<leader>gh", group = "hunks" },
               { "<leader>q",  group = "quit/session" },
               { "<leader>t",  group = "terminal" },
               { "<leader>o",  group = "other file" },
               { "<leader>s",  group = "search" },
               { "<leader>u",  group = "ui" },
               { "<leader>p",  group = "plugin" },
               { "<leader>x",  group = "diagnostics/quickfix" },
               { "[",          group = "prev" },
               { "]",          group = "next" },
               { "g",          group = "goto" },
               { "gs",         group = "surround" },
               { "z",          group = "fold" },
               {
                  "<leader>b",
                  group = "buffer",
                  expand = function()
                     return require("which-key.extras").expand.buf()
                  end,
               },
               {
                  "<leader>w",
                  group = "windows",
                  proxy = "<c-w>",
                  expand = function()
                     return require("which-key.extras").expand.win()
                  end,
               },
            },
         },
      },
      keys = {
         {
            "<leader>?",
            function()
               require("which-key").show({ global = false })
            end,
            desc = "Buffer Keymaps (which-key)",
         },
         {
            "<c-w><space>",
            function()
               require("which-key").show({ keys = "<c-w>", loop = true })
            end,
            desc = "Window Hydra Mode (which-key)",
         },
      },
      config = function(_, opts)
         local wk = require("which-key")
         wk.setup(opts)
      end,
   },
}
