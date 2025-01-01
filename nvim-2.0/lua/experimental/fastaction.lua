return {
{
    "Chaitanyabsprip/fastaction.nvim",
    lazy = false,
    enabled = false,
    opts = {
      register_ui_select = true,
      popup = {
        x_offset = vim.api.nvim_get_option_value("columns", {}),
        border = "single",
        title = "select:",
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>ca", function() require("fastaction").code_action() end, desc = "code action", buffer = true },
      -- stylua: ignore end
    },
  },
  }
