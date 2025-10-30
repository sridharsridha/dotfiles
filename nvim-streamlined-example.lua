-- Streamlined Neovim Configuration Example for C++/Python Development
-- This is a complete, minimal configuration optimized for your workflow

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Core Settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.expandtab = true
opt.shiftwidth = 3
opt.tabstop = 3
opt.smartindent = true
opt.undofile = true
opt.termguicolors = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.clipboard = "unnamedplus"
opt.scrolloff = 8
opt.completeopt = "menu,menuone,noselect"

-- Core Keymaps
local keymap = vim.keymap.set
keymap("i", "jk", "<Esc>", { desc = "Exit insert mode" })
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
keymap("n", "<leader>s", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>qa<CR>", { desc = "Quit all" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Essential Plugins
require("lazy").setup({
  -- Syntax highlighting and text objects
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "python", "lua", "vim", "vimdoc", "markdown", "bash" },
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp", -- Modern completion
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- C++ LSP
      if vim.fn.executable("clangd") == 1 then
        lspconfig.clangd.setup({
          cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
          capabilities = require("blink.cmp").get_lsp_capabilities(),
        })
      end

      -- Python LSP
      if vim.fn.executable("pyright") == 1 then
        lspconfig.pyright.setup({
          capabilities = require("blink.cmp").get_lsp_capabilities(),
        })
      end

      -- Lua LSP (for Neovim config)
      if vim.fn.executable("lua-language-server") == 1 then
        lspconfig.lua_ls.setup({
          capabilities = require("blink.cmp").get_lsp_capabilities(),
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        })
      end

      -- Work-specific LSPs (only if available)
      local work_lsps = {
        { cmd = "/home/sridharn/bin/artoolslsp/ar-grok-ls", name = "argrok" },
        { cmd = "/home/sridharn/bin/artoolslsp/ar-formatdiff-ls", name = "arformatdiff" },
        { cmd = "/home/sridharn/bin/artoolslsp/ar-pylint-ls", name = "arpylint" },
      }

      for _, lsp in ipairs(work_lsps) do
        if vim.fn.executable(lsp.cmd) == 1 then
          lspconfig[lsp.name] = {
            default_config = {
              cmd = { lsp.cmd },
              root_dir = function() return "/src" end,
              filetypes = lsp.name == "arpylint" and { "python" } or {},
            },
          }
          lspconfig[lsp.name].setup({})
        end
      end

      -- LSP keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          keymap("n", "gd", vim.lsp.buf.definition, opts)
          keymap("n", "gr", vim.lsp.buf.references, opts)
          keymap("n", "K", vim.lsp.buf.hover, opts)
          keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          keymap("n", "<leader>cr", vim.lsp.buf.rename, opts)
          keymap("n", "<leader>cf", vim.lsp.buf.format, opts)
        end,
      })
    end,
  },

  -- Completion
  {
    "saghen/blink.cmp",
    version = "v0.*",
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default" },
      appearance = { use_nvim_cmp_as_default = true },
      signature = { enabled = true },
    },
  },

  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Search current word" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
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
      })
      telescope.load_extension("fzf")
    end,
  },

  -- Git Integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function() gs.next_hunk() end, { desc = "Next hunk" })
        map("n", "[c", function() gs.prev_hunk() end, { desc = "Prev hunk" })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", gs.blame_line, { desc = "Blame line" })
      end,
    },
  },

  -- Terminal Integration
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      { "<leader>tg", "<cmd>TermExec cmd='git status'<cr>", desc = "Git status" },
      { "<leader>tb", "<cmd>TermExec cmd='make build'<cr>", desc = "Build project" },
      { "<leader>tt", "<cmd>TermExec cmd='make test'<cr>", desc = "Run tests" },
    },
    opts = {
      direction = "horizontal",
      size = 15,
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        python = { "black", "isort" },
        cpp = { "clang_format" },
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- Better Diagnostics UI
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix" },
    },
    opts = {},
  },

  -- Status Line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
           require("catppuccin").setup({
              flavour = "mocha",
              transparent_background = false,
           })
           vim.cmd.colorscheme("catppuccin")
        end,
    },

  -- Which-key for keybinding help
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>c", group = "Code" },
        { "<leader>f", group = "Find" },
        { "<leader>h", group = "Git Hunk" },
        { "<leader>t", group = "Terminal" },
        { "<leader>x", group = "Diagnostics" },
      },
    },
  },

  -- File Explorer (optional, can use netrw instead)
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File Explorer" },
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
}, {
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Custom Commands for Build/Test
vim.api.nvim_create_user_command("Build", function(opts)
  local cmd = opts.args ~= "" and opts.args or "make"
  vim.cmd("TermExec cmd='" .. cmd .. "'")
end, { nargs = "?" })

vim.api.nvim_create_user_command("Test", function(opts)
  local cmd = opts.args ~= "" and opts.args or "make test"
  vim.cmd("TermExec cmd='" .. cmd .. "'")
end, { nargs = "?" })

-- Auto-save last position in file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
