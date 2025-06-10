return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      {
        "<leader>fo",
        function()
          local alternates = require("utils.alternate").get_alternate_files()
          if #alternates > 0 then
            require("telescope.pickers").new({}, {
              prompt_title = "Alternate Files",
              finder = require("telescope.finders").new_table({
                results = alternates,
              }),
              sorter = require("telescope.config").values.generic_sorter({}),
            }):find()
          else
            vim.notify("No alternate files found", vim.log.levels.INFO)
          end
        end,
        desc = "Find Alternate Files",
      },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },
}