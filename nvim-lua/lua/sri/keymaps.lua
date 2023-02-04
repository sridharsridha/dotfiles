-- import our vim objects
local vim, api, fn, g = vim, vim.api, vim.fn, vim.g

-- import our map functions file
local mappings = require('sri.utils.map')

-- dereference all the functions
-- examples https://github.com/Th3Whit3Wolf/dots/blob/main/private_dot_config/private_nvim/private_lua/private_mapping.lua
local nnoremap = mappings.nnoremap
local inoremap = mappings.inoremap
local vnoremap = mappings.vnoremap
local xnoremap = mappings.xnoremap
local cnoremap = mappings.cnoremap
local nmap = mappings.nmap
local imap = mappings.imap
local vmap = mappings.vmap

-- Set leader key to space
g.mapleader = " "

-- wrapper function around the native mapping function
-- sets some sane defaults
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then
      options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Helper functions to write create abbreveations
local function cnoreabbrev(command)
    api.nvim_command("cnoreabbrev " .. command)
end

local function iabbrev(command)
    api.nvim_command("iabbrev " .. command)
end

-- Allow misspellings
cnoreabbrev "Qa qa"
cnoreabbrev "Q q"
cnoreabbrev "Qall qall"
cnoreabbrev "Q! q!"
cnoreabbrev "Qall! qall!"
cnoreabbrev "qQ q@"
cnoreabbrev "Bd bd"
cnoreabbrev "bD bd"
cnoreabbrev "qw wq"
cnoreabbrev "Wq wq"
cnoreabbrev "WQ wq"
cnoreabbrev "Wq wq"
cnoreabbrev "Wa wa"
cnoreabbrev "wQ wq"
cnoreabbrev "W w"
cnoreabbrev "W! w!"

-- Yank from cursor position to end-of-line
nnoremap('Y', 'y$')

-- Select blocks after indenting
xnoremap("<", "<gv")
xnoremap(">", ">gv|")

-- Use tab for indenting
nnoremap("<Tab>", ">>_")
nnoremap("<S-Tab>", "<<_")
vnoremap("<Tab>", ">gv")
vnoremap("<S-Tab>", "<gv")

inoremap("jk", "<ESC>")
inoremap("kj", "<ESC>")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- remap j and k to move across display lines and not real lines
vim.api.nvim_set_keymap("n", "k", "gk", {noremap = true})
vim.api.nvim_set_keymap("n", "gk", "k", {noremap = true})
vim.api.nvim_set_keymap("n", "j", "gj", {noremap = true})
vim.api.nvim_set_keymap("n", "gj", "j", {noremap = true})
