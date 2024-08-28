return {
   { -- Autoformat
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = {
         {
            -- Customize or remove this keymap to your liking
            "<leader>cf",
            -- function()
            --    require("conform").format({ async = true })
            -- end,
            function()
               local lines = vim.fn.system('git diff --unified=0'):gmatch('[^\n\r]+')
               local ranges = {}
               for line in lines do
                  if line:find('^@@') then
                     local line_nums = line:match('%+.- ')
                     if line_nums:find(',') then
                        local _, _, first, second = line_nums:find('(%d+),(%d+)')
                        table.insert(ranges, {
                           start = { tonumber(first), 0 },
                           ['end'] = { tonumber(first) + tonumber(second), 0 },
                        })
                     else
                        local first = tonumber(line_nums:match('%d+'))
                        table.insert(ranges, {
                           start = { first, 0 },
                           ['end'] = { first + 1, 0 },
                        })
                     end
                  end
               end
               local format = require('conform').format
               for _, range in pairs(ranges) do
                  format {
                     range = range,
                     async = true,
                  }
               end
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
