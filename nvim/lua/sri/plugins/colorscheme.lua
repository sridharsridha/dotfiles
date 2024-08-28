return {
   {
      "rafi/theme-loader.nvim",
      lazy = false,
      priority = 99,
      opts = { initial_colorscheme = "grvbox-flat", fallback_colorscheme = "gruvbox" },
   },
   { "ellisonleao/gruvbox.nvim" },
   {
      "eddyekofo94/gruvbox-flat.nvim",
      config = function()
         vim.g.gruvbox_flat_style = "hard"
      end,
   },
   -- {
   --    "catppuccin/nvim",
   --    name = "catppuccin",
   --    config = function()
   --       require("catppuccin").setup({
   --          flavour = "mocha", -- latte, frappe, macchiato, mocha
   --          -- background = {     -- :h background
   --          --    light = "latte",
   --          --    dark = "mocha",
   --          -- },
   --          integrations = {
   --             nvimtree = true,
   --             treesitter = true,
   --             mini = {
   --                enabled = true,
   --                indentscope_color = "",
   --             },
   --             diffview = true,
   --             fidget = true,
   --             mason = true,
   --             which_key = true,
   --             telescope = {
   --                enabled = true,
   --                style = "nvchad"
   --             }
   --             -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
   --          },
   --       })
   --       -- vim.cmd.colorscheme "catppuccin"
   --    end,
   --
   -- }

}
