return {
{
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
   keys = {
      -- stylua: ignore start
      { "<C-p>", function() require("fzf-lua").files() end, desc = "find files" },
      { "<C-/>", function() require("fzf-lua").live_grep() end, desc = "live grep" },
      { "<C-/>", function() require("fzf-lua").grep_visual() end, mode = "x", desc = "grep selection" },
      { "<C-g>", function() require("fzf-lua").grep() end, desc = "grep selection" },
      { "<C-g>", function() require("fzf-lua").grep() end, mode = "x", desc = "grep selection" },
      { "<C-?>", function() require("fzf-lua").builtin() end, desc = "grep selection" },
      -- stylua: ignore end
    },
    config = function()
       require("fzf-lua").setup({'max-perf'})
    end
}
}
