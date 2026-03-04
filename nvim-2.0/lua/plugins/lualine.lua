return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "catppuccin" },
    config = function()
      local gl = require("config/global")
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = gl.is_remote
            and { "diagnostics" }
            or { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
}
