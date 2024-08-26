return {
   { -- Adds git related signs to the gutter, as well as utilities for managing changes
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      cmd = "Gitsigns",
      config = function()
         require("gitsigns").setup({
            signs = {
               add = { text = "+" },
               change = { text = "~" },
               delete = { text = "_" },
               topdelete = { text = "‾" },
               changedelete = { text = "│" },
            },
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
               virt_text = true,
            },
         })
      end,
   },
   {
      "akinsho/git-conflict.nvim",
      opt = {
         default_mappings = true,     -- disable buffer local mapping created by this plugin
         default_commands = true,     -- disable commands created by this plugin
         disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
         list_opener = 'copen',       -- command or function to open the conflicts list
         highlights = {               -- They must have background color, otherwise the default color will be used
            incoming = 'DiffAdd',
            current = 'DiffChange',
         }
      }
   },
   { "sindrets/diffview.nvim", cmd = "DiffviewOpen", opts = {} },
}
