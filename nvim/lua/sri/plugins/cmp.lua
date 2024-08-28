return {
   { -- Autocompletion
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
         -- Snippet Engine & its associated nvim-cmp source
         {
            "L3MON4D3/LuaSnip",
            build = (function()
               return "make install_jsregexp"
            end)()
         },
         -- "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lsp-signature-help",
         "ray-x/cmp-treesitter",
         "saadparwaiz1/cmp_luasnip",
         "hrsh7th/cmp-cmdline",
         "dmitmel/cmp-cmdline-history",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-buffer",
         "andersevenrud/cmp-tmux",
         "rafamadriz/friendly-snippets",
         "onsails/lspkind.nvim",
         {
            "Exafunction/codeium.nvim",
            dependencies = {
               "nvim-lua/plenary.nvim",
               "hrsh7th/nvim-cmp",
            },
            build = ":Codeium Auth",
            config = function()
               require("codeium").setup({
               })
            end
         },
      },
      config = function()
         vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
         local cmp = require("cmp")
         local luasnip = require("luasnip")
         local neogen = require("neogen")
         local lspkind = require('lspkind')
         local defaults = require("cmp.config.default")()
         local auto_select = true

         require("luasnip.loaders.from_vscode").lazy_load()
         luasnip.config.setup({
            region_check_events = "CursorMoved",
            delete_check_events = "TextChanged",
         })
         cmp.setup({
            ghost_text = { enabled = true },
            auto_brackets = {},
            preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
            completion = {
               completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
            },
            view = {
               entries = "native", -- can be "custom", "wildmenu" or "native"
            },
            snippet = {
               expand = function(args)
                  luasnip.lsp_expand(args.body)
               end,
            },
            sources = cmp.config.sources({
               { name = "nvim_lsp" },
               { name = "nvim_lsp_signature_help" },
               { name = "codeium" },
               { name = 'treesitter' },
               { name = "luasnip" },
            }, { -- group 2 only if nothing in above had results
               { name = "path" },
               { name = "buffer" },
               { name = "tmux" },
            }),
            formatting = {
               format = lspkind.cmp_format({
                  mode = "text",
                  maxwidth = 50,
                  ellipsis_char = '...',
               })
            },
            mapping = cmp.mapping.preset.insert({
               ["<C-j>"] = cmp.mapping(
                  cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                  { "i", "s", "c" }
               ),
               ["<C-k>"] = cmp.mapping(
                  cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                  { "i", "s", "c" }
               ),
               ["<C-b>"] = cmp.mapping.scroll_docs(-4),
               ["<C-f>"] = cmp.mapping.scroll_docs(4),
               ["<c-e>"] = cmp.mapping.abort(),
               ["<c-y>"] = cmp.mapping.confirm({ select = true }),
               ["<c-,>"] = cmp.mapping.confirm({ select = true }),
               ["<C-l>"] = cmp.mapping(function(fallback)
                  if luasnip.expand_or_locally_jumpable() then
                     luasnip.expand_or_jump()
                  elseif neogen.jumpable() then
                     neogen.jump_next()
                  else
                     fallback()
                  end
               end, { "i", "s" }),
               ["<C-h>"] = cmp.mapping(function(fallback)
                  if luasnip.locally_jumpable(-1) then
                     luasnip.jump(-1)
                  elseif neogen.jumpable(-1) then
                     neogen.jump_prev()
                  else
                     fallback()
                  end
               end, { "i", "s" }),
            }),
            experimental = {
               ghost_text = {
                  hl_group = "CmpGhostText",
               },
            },
            sorting = defaults.sorting,
         })
         -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
         cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            view = {
               entries = { name = 'wildmenu', separator = ' | ' }
            },
            sources = {
               { name = "buffer" },
               { name = "cmdline_history" },
            },
         })

         -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
         cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            view = {
               entries = { name = 'wildmenu', separator = ' | ' }
            },
            sources = {
               { name = "path" },
               { name = "cmdline",         keyword_length = 3, max_item_count = 5 },
               { name = "cmdline_history", keyword_length = 3, max_item_count = 5 },
            },
         })

         vim.cmd([[
			           highlight! link CmpItemMenu Comment
			           " gray
			           highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
			           " front
			           highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
			           highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
			           highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
			         ]])
      end,
   },
}
