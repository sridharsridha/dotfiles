scriptencoding utf-8

" General:
" ----------------------------------------------------------------------------
set path+=**                 " Directories to search when using gf
set report=0                 " Don't report on line changes
" set hidden                   " hide buffers when abandoned instead of unload
set magic                    " For regular expressions turn magic on
set virtualedit=block        " Position cursor anywhere in visual block
set noerrorbells visualbell t_vb= " No bell sounds.
set colorcolumn=+0
set timeoutlen=300
set ttimeoutlen=30
set wrap
" always use system clipboard as unnamed register
set clipboard=unnamed,unnamedplus

"  ShaDa/viminfo:
"   ' - Maximum number of previously edited files marks
"   < - Maximum number of lines saved for each register
"   @ - Maximum number of items in the input-line history to be
"   s - Maximum size of an item contents in KiB
"   h - Disable the effect of 'hlsearch' when loading the shada
set shada=!,'300,<50,@100,s10,h
" ----------------------------------------------------------------------------

" WildMenu:
" ----------------------------------------------------------------------------
set wildignorecase
set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
set wildignore+=__pycache__,*.egg-info,.pytest_cache,.mypy_cache/**
set wildcharm=<C-z>  " substitue for 'wildchar' (<Tab>) in macros
" ----------------------------------------------------------------------------

" Directories:
" ----------------------------------------------------------------------------
" use ~/.cache/darkvim/ as default data directory, create the directory if
" it does not exist.
function s:create_cache_directory(dir)
   if finddir(a:dir) ==# ''
      silent call mkdir(a:dir, 'p', 0700)
   endif
endfunction

let g:data_dir = $HOME . '/.cache/darkvim/'
call s:create_cache_directory(g:data_dir . 'backup')
call s:create_cache_directory(g:data_dir . 'swap')
call s:create_cache_directory(g:data_dir . 'undofile')
call s:create_cache_directory(g:data_dir . 'conf')
call s:create_cache_directory(g:data_dir . 'view')
set undodir=$HOME/.cache/darkvim/undofile
set backupdir=$HOME/.cache/darkvim/backup
set directory=$HOME/.cache/darkvim/swap
set viewdir=$HOME/.cache/darkvim/view/

set undofile
set history=100
" ----------------------------------------------------------------------------

" Indents:
" ----------------------------------------------------------------------------
set textwidth=85  " Text width maximum chars before wrapping
set smartindent   " Enable smart indent.
set tabstop=3     " The number of spaces a tab is
set shiftwidth=3  " Number of spaces to use in auto(indent)
set softtabstop=3 " While performing editing operations
" ----------------------------------------------------------------------------

" Searching:
" ----------------------------------------------------------------------------
set ignorecase      " Search ignoring case
set smartcase       " Keep case when searching with *
set infercase       " Adjust case in insert completion mode
set complete=.,w,b  " C-n completion: Scan buffers and windows
set inccommand=split

if executable('rg')
   let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '')
elseif executable('ag')
   let &grepprg = 'ag --vimgrep' . (&smartcase ? ' --smart-case' : '')
endif
" ----------------------------------------------------------------------------

" Behaviour:
" ----------------------------------------------------------------------------
set splitbelow splitright " Splits open bottom right
set switchbuf=usetab,newtab
set completeopt=menuone   " menuone: show the pupmenu when only one match
set completeopt+=noselect " Do not select a match in the menu
" Do not insert any text for a match until the user selects from menu
set completeopt+=noinsert " Do not auto insert the match
set completeopt+=preview " show extra information about the current completion
" ----------------------------------------------------------------------------

" Editor UI:
" ----------------------------------------------------------------------------
set number           " Don't show line numbers
set nofoldenable
set showtabline=1
set conceallevel=2 concealcursor=niv " For snippet_complete marker
set lazyredraw                          " Don't redraw while executing macros.
set showtabline=2
" ----------------------------------------------------------------------------

