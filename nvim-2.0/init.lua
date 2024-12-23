require("config/autocmds")
require("config/options")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("config/mappings")
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
       change_detection = {
        notify = false,
    },
	ui = {
		border = "single",
	},
   performance = {
      rtp = {
         disabled_plugins = {
            "2html_plugin",
            "spellfile",
            "man",
            "matchparen",
            "editorconfig",
            "osc52",
            "bugreport",
            "compiler",
            "ftplugin",
            "getscript",
            "getscriptPlugin",
            "gzip",
            "logipat",
            "matchit",
            "optwin",
            "rplugin",
            "rrhelper",
            "spellfile_plugin",
            "synmenu",
            "tar",
            "tarPlugin",
            "tutor",
            "vimball",
            "vimballPlugin",
            "zip",
            "zipPlugin",
            "netrw",
            "netrwFileHandlers",
            "netrwPlugin",
            "netrwSettings",
            "syntax",
            "tohtml",
         },
      },
   },
})
