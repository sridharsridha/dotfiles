local g = vim.g
local opt = vim.opt
local util = require('sri/utils/dir')
local prefix = vim.env.XDG_CACHE_HOME or vim.fn.expand("~/.cache")

g.mapleader = " "
g.maplocalleader = ','

opt.path:append '**'
opt.magic = true
opt.wrap = true
opt.mouse = 'a'
opt.timeoutlen = 500
opt.clipboard = 'unnamedplus'
opt.completeopt = 'menuone,noinsert,noselect,preview'
opt.wildmode = 'longest,list,full'
opt.wildignorecase = true
opt.undodir = {util.mkdir(prefix .. "/nvim/.undo//")}
opt.backupdir = {util.mkdir(prefix .. "/nvim/.bkp//")}
opt.directory = {util.mkdir(prefix .. "/nvim/.swp//")}
opt.number = true
opt.relativenumber = true
opt.showmatch = true
opt.foldenable = false
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true
opt.formatoptions = 'jql'
opt.termguicolors = true
opt.tabstop = 3
opt.shiftwidth = 3
opt.textwidth = 85
opt.history = 10000
opt.lazyredraw = false
opt.synmaxcol = 240
opt.updatetime = 250

-- -- Disable builtin plugins
g.loaded_2html_plugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logipat = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_matchit = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_rrhelper = 1
g.loaded_spellfile_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tutor = 1
g.rplugin = 1
g.loaded_synmenu = 1
g.loaded_optwin = 1
g.loaded_compiler = 1
g.loaded_bugreport = 1
g.loaded_ftplugin = 1

