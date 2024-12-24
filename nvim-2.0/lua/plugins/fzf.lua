return {
{
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
   keys = {
      -- stylua: ignore start
      { "<C-p>", function() require("fzf-lua").files() end, desc = "find files" },
      { "<C-l>", function() require("fzf-lua").live_grep() end, desc = "live grep" },
      { "<C-l>", function() require("fzf-lua").grep_visual() end, mode = "x", desc = "grep selection" },
      -- stylua: ignore end
    },
    opts = {
      -- winopts = {
      --   height = 0.25,
      --   width = 0.4,
      --   row = 0.5,
      --   border = "single",
      -- },
      fzf_opts = {
        ["--no-info"] = "",
        ["--info"] = "hidden",
        ["--padding"] = "13%,5%,13%,5%",
        ["--header"] = " ",
        ["--no-scrollbar"] = "",
      },
    },
}
}
