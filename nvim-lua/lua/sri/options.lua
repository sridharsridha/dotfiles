-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g   
local opt = vim.opt 

----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.path:append '**'
opt.magic = true
opt.wrap = true
opt.mouse = 'a'         
opt.clipboard = 'unnamedplus'
opt.completeopt = 'menuone,noinsert,noselect,preview'

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true     
opt.relativenumber = true
opt.showmatch = true   
opt.foldenable = false
opt.splitright = true
opt.splitbelow = true 
opt.ignorecase = true  
opt.smartcase = true    
opt.wrap = true
opt.breakindent = true
opt.linebreak = true     
opt.formatoptions = 'jql'
opt.termguicolors = true  

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        
opt.shiftwidth = 3          
opt.tabstop = 3            
opt.smartindent = true    

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true    
opt.history = 10000 
opt.lazyredraw = true
opt.synmaxcol = 240 
opt.updatetime = 250 

-- Disable nvim intro
opt.shortmess:append "sI"

o.termguicolors = true
o.timeoutlen = 500
o.wrap = true
o.clipboard = 'unnamedplus'



