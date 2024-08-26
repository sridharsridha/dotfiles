return {
   { -- Autoformat
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = {
         {
            -- Customize or remove this keymap to your liking
            "<leader>cf",
            function()
               require("conform").format({ async = true })
            end,
            mode = { "n", "v" },
            desc = "Format buffer",
         },
      },
      opts = {
         notify_on_error = true,
         format_on_save = {
            lsp_fallback = true,
         },
         formatters_by_ft = {
            python = { "a" },
            cpp = { "a" },
            tac = { "a" },
         },
         formatters = {
            shfmt = {
               prepend_args = { "-i", "2" },
            },
            a = {
               command = "a4",
               args = { "formatfile", "-f", "$FILENAME" },
               stdin = false,
               inherit = false,
            },
         },
      },
   },
   {
      "zapling/mason-conform.nvim",
      event = "BufReadPre",
      config = true,
      dependencies = {
         "williamboman/mason.nvim",
         "stevearc/conform.nvim",
      },
   },
}
