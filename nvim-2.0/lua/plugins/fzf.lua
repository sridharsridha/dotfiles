return {
{
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
   keys = {
      -- stylua: ignore start
      { "<C-p>", function() require("fzf-lua").files() end, desc = "find files" },
      { "<leader>ff", function() require("fzf-lua").files() end, desc = "find files" },
      { "<leader>/", function() require("fzf-lua").live_grep() end, desc = "live grep" },
      { "<leader>/", function() require("fzf-lua").grep_visual() end, mode = "x", desc = "grep selection" },
      { "<leader>fg", function() require("fzf-lua").grep() end, desc = "grep" },
      { "<leader>?", function() require("fzf-lua").builtin() end, desc = "FZF builtin" },
      -- stylua: ignore end
    },
    config = function()
       -- require("fzf-lua").setup({'max-perf'})
       require("fzf-lua").setup()
    end
}
}
