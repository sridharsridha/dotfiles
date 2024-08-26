return {
   { "echasnovski/mini.tabline",    opts = {} },

   { "echasnovski/mini.statusline", opts = { use_icons = false } },

   {
      "echasnovski/mini.indentscope",
      keys = { "j", "k" },
      opts = function(_, opts)
         opts.draw = {
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
            split = "sh",
            vsplit = "sv",

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

   {
      "yorickpeterse/nvim-pqf",
      ft = "qf",
      event = "QuickFixCmdPost",
      config = function()
         require('pqf').setup({
            signs = {
               error = { text = '', hl = 'DiagnosticSignError' },
               warning = { text = '', hl = 'DiagnosticSignWarn' },
               info = { text = '', hl = 'DiagnosticSignInfo' },
               hint = { text = '󰌵', hl = 'DiagnosticSignHint' },
            },
         })
      end,
   },

   {
      "kevinhwang91/nvim-hlslens",
      opts = {
         calm_down = true,
      },
      keys = {
         -- FYI: debug mapping with `:map ...`
         {
            "n",
            [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
            noremap = true,
            silent = true,
            desc = "Next Match",
         },
         {
            "N",
            [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
            noremap = true,
            silent = true,
            desc = "Previous Match",
         },

         -- TODO: Respect smartcase with:
         --  https://github.com/olimorris/dotfiles-1/blob/0a3168e068e21fd9f51be27fe7bdb72ef2643d88/.config/nvim/lua/plugins/hlslens.lua#L11-L31
         { "*",  [[*<Cmd>lua require('hlslens').start()<CR>]],  noremap = true, silent = true, desc = "Match Word" },
         { "#",  [[#<Cmd>lua require('hlslens').start()<CR>]],  noremap = true, silent = true, desc = "Match Word" },
         { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], noremap = true, silent = true, desc = "Match Word" },
         { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], noremap = true, silent = true, desc = "Match Word" },
      },
   },

   {
      "max397574/better-escape.nvim",
      opts = {
         timeout = vim.o.timeoutlen,
         default_mappings = true,
      }
   },

   {
      "nacro90/numb.nvim",
      event = { "CmdlineEnter" },
      config = function()
         require("numb").setup()
      end,
   },

   -- {
   -- 	"winston0410/range-highlight.nvim",
   -- 	dependencies = { "winston0410/cmd-parser.nvim" },
   -- 	config = true,
   -- },

   {
      "kawre/neotab.nvim",
      event = "InsertEnter",
      opts = {},
   },

   {
      "AckslD/muren.nvim",
      cmd = { "MurenOpen", "MurenClose", "MurenToggle" },
      config = true,
   },
}
