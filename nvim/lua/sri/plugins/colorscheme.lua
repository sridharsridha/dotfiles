return {
   {
      "rafi/theme-loader.nvim",
      lazy = false,
      priority = 99,
      opts = { initial_colorscheme = "gruvbox-flat", fallback_colorscheme = "gruvbox" },
   },
   { "ellisonleao/gruvbox.nvim" },
   {
      "eddyekofo94/gruvbox-flat.nvim",
      config = function()
         vim.g.gruvbox_flat_style = "dark"
      end,
   }
}
