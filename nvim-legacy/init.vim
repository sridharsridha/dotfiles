set nocompatible

" Load local config
if filereadable(fnamemodify(expand('<sfile>'), ':h').'/init.local.vim')
   source <sfile>:h/init.local.vim
endif

" Create vim plug if not already exist
if empty(glob('~/.config/nvim/autoload/plug.vim'))
   silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" PLUGINS:
call plug#begin('~/.config/nvim/plugged')

" On-demand lazy load
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
nnoremap <silent> s :<c-u>WhichKey 's'<CR>

" Git
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
" Plug 'jreybert/vimagit'
" Plug 'cohama/agit.vim'

" Faster j k movements.
Plug 'tpope/vim-repeat'
Plug 'rhysd/accelerated-jk'

" Mark workds under cursor
" Plug 'inkarkat/vim-ingo-library'
" Plug 'inkarkat/vim-mark'

Plug 'AndrewRadev/bufferize.vim'

" Operator for deleting or adding brackets and quotes 'saiw(' 'sdb' 'sd(' 'srb"' 'sr("'
Plug 'machakann/vim-sandwich'

" Adds comment action with 'gc'
Plug 'tpope/vim-commentary'

" Adds the surround motion bound to s
Plug 'tpope/vim-surround'

Plug 'farmergreg/vim-lastplace'

" Search and Files
" Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pelodelfuego/vim-swoop'
Plug 'jremmen/vim-ripgrep'

" QuickFix
Plug 'yssl/QFEnter'
Plug 'milkypostman/vim-togglelist'

" Visuals
Plug 'mhinz/vim-startify'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'szw/vim-maximizer'

" Code editing helpers
Plug 'Raimondi/delimitMate'
Plug 'ntpeters/vim-better-whitespace'
Plug 'derekwyatt/vim-fswitch'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Documentation
Plug 'sbdchd/neoformat'
Plug 'gauteh/vim-cppman'
Plug 'bfrg/vim-cpp-modern', {'for': 'cpp'}

" Tmux navigation support
Plug 'christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'

"Visual
" Plug 'luochen1990/rainbow'
" let g:rainbow_active = 1

" Colorscheme
" Plug 'morhetz/gruvbox'
Plug 'ellisonleao/gruvbox.nvim'
" Plug 'shaunsingh/nord.nvim'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Load local bundle config
if filereadable(fnamemodify(expand('<sfile>'), ':h').'/bundles.local.vim')
   source <sfile>:h/bundles.local.vim
endif

call plug#end()

" General:
set path+=**
set magic
set mouse=a
set wrap
" By default timeoutlen is 1000 ms
set timeoutlen=400
set clipboard=unnamedplus
set completeopt=menuone,noinsert,noselect,preview
set showmatch
" Update sign column every quarter second
set updatetime=250

" WildMenu:
" The first tab completes as much as it can, second tab displays a list of
" options, and the third tab will present a list that allows you to scroll
" through and select filenames beginning with that prefix.
set wildmode=longest,list,full
set wildignorecase

" Directories:
" use ~/.cache/darkvim/ as default data directory, create the directory if
" it does not exist.
function s:create_cache_directory(dir)
   if finddir(a:dir) ==# ''
      silent call mkdir(a:dir, 'p', 0700)
   endif
endfunction

let g:data_dir = $HOME . '/.cache/nvim/'
call s:create_cache_directory(g:data_dir . 'backup')
call s:create_cache_directory(g:data_dir . 'swap')
call s:create_cache_directory(g:data_dir . 'undofile')
call s:create_cache_directory(g:data_dir . 'conf')
call s:create_cache_directory(g:data_dir . 'view')
set undodir=$HOME/.cache/nvim/undofile
set backupdir=$HOME/.cache/nvim/backup
set directory=$HOME/.cache/nvim/swap
set viewdir=$HOME/.cache/nvim/view/

set undofile
set history=10000

" Indents:
set textwidth=85  " Text width maximum chars before wrapping
set tabstop=3
set expandtab

" Searching:
set autowrite
set nojoinspaces
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

" Behaviour:
set formatoptions-=cro    " stop annoying auto commenting on new lines

" Editor UI:
set number
set norelativenumber
set foldenable
set conceallevel=2 concealcursor=niv " For snippet_complete marker
set lazyredraw                       " Don't redraw while executing macros.
set showtabline=2
set termguicolors
set splitright
set splitbelow

" Accelerated jk:
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" PLUGIN CONFIGURATIONS:

" Mapping Hints:
augroup vim_plug_custom
   " Automatically install missing plugins on startup
   autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif
augroup END

" FuzzyFinder:
" CtrlP

" Statusline:
set background=dark
colorscheme gruvbox
" colorscheme nord
" let g:airline_theme='base16_nord'
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline#extensions#tabline#enabled = 1
" let g:gruvbox_italic = 1
" let g:gruvbox_hls_cursor = 'purple'
" let g:gruvbox_italicize_comments = 1
" let g:gruvbox_italicize_strings = 1

" StartingWindow:
let g:startify_padding_left = 10
let g:startify_enable_special = 0
let g:startify_change_to_vcs_root = 1
let g:startify_lists = [
         \ { 'type': 'dir'       },
         \ { 'type': 'files'     },
         \ { 'type': 'sessions'  },
         \ { 'type': 'bookmarks' },
         \ { 'type': 'commands' },
         \ ]
let  g:startify_bookmarks =  [
         \ {'v': '~/.config/nvim'},
         \ {'d': '~/dotfiles' }
         \ ]
let g:startify_commands = [
         \ {'ch':  ['Health Check', ':checkhealth']},
         \ {'ps': ['Plugins status', ':PlugStatus']},
         \ {'pu': ['Update vim plugins',':PlugUpdate | PlugUpgrade']},
         \ {'h':  ['Help', ':help']},
         \ ]
let g:startify_custom_header = [
         \ "",
         \]

" Quickfix QFEnter:
let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>']
let g:qfenter_keymap.vopen = ['sv', '<C-v>']
let g:qfenter_keymap.hopen = ['sg', '<C-g>', '<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['st', '<C-t>']

" ToggleList:
let g:toggle_list_no_mappings = 0
nnoremap tp :set invpaste<CR>
nnoremap th :set invhlsearch<CR>
nnoremap tn :set invnumber<CR>
nnoremap ts :GitGutterSignsToggle<CR>
nnoremap <silent> tl :call ToggleLocationList()<CR>
nnoremap <silent> tq :call ToggleQuickfixList()<CR>
nnoremap tw :set invwrap<CR>

" Fswitch:
noremap <Space>aa :FSHere<CR>
noremap <Space>av :FSSplitRight<CR>
noremap <Space>ag :FSSplitBelow<CR>
let g:fsnonewfiles = 1
augroup fswitch_custom
   au!
   au BufEnter *.tac  let b:fswitchdst = "tin,itin,cpp,h" | let b:fswitchlocs = 'reg:|./|./**|'
   au BufEnter *.tin  let b:fswitchdst = "tac,itin,cpp,h" | let b:fswitchlocs = 'reg:|./|./**|'
   au BufEnter *.itin  let b:fswitchdst = "tin,tac,cpp,h" | let b:fswitchlocs = 'reg:|./|./**|'
   au BufEnter *.h  let b:fswitchdst = "c,cpp,cc,m" | let b:fswitchlocs = 'reg:|./|./**|'
   au BufEnter *.cc let b:fswitchdst = "h,hpp" | let b:fswitchlocs = 'reg:|./|./**|'
augroup END

" Ultisnip:
function! s:RemoveDebugPrints()
  let save_cursor = getcurpos()
  :g/\/\/\ prdbg$/d
  call setpos('.', save_cursor)
endfunction
noremap <Space>cd call s:RemoveDebugPrints()

" Neoformat:
" custom setting for clangformat
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 3}"']
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']

" vim-maximizer
let g:maximizer_default_mapping_key = 'sz'

" GLOBAL MAPPINGS:
" Use jk switch to normal mode
" Press i to enter insert mode, and ii to exit insert mode.
" inoremap ii <Esc>
inoremap jk <Esc>
inoremap kj <Esc>
vnoremap jk <Esc>
vnoremap kj <Esc>

" Replace
nnoremap R "_d"

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
         \ 'zt' : (winline() == &scrolloff + 1) ? 'zb' : 'zz'

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting in visual mode
nnoremap > >>_
nnoremap < <<_

" smart up and down
nnoremap <silent><Down> gj
nnoremap <silent><Up> gk
nnoremap Y y$

" The plugin rhysd/accelerated-jk moves through display-lines in normal mode,
" these mappings will move through display-lines in visual mode too.
vnoremap j gj
vnoremap k gk

" Start an external command with a single bang
nnoremap !  :!

" Search result navigation
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
" nnoremap g* g*zz
" nnoremap g# g#zz

" use up down on pum
imap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
imap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
imap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
imap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" Buffer movement
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
noremap sn :bnext<CR>
noremap sp :bprevious<CR>
noremap sb :CtrlPBuffer<CR>

" new line in normal mode and back
nnoremap <Enter> o<ESC>
noremap q :q<CR>
noremap <C-q> :q!<CR>

" disable hl with 2 esc
noremap <silent><esc> <esc>:noh<CR><esc>

" Split windows.
noremap sv <C-w>v
noremap sg <C-w>s
noremap s= <C-w>=
" noremap sw :Windows<CR>

" turn on redirection in curl (for opening log file links from dashboard)
if !exists("g:netrw_http_cmd") && !exists("g:netrw_http_xcmd")
   let g:netrw_http_cmd="curl"
   let g:netrw_http_xcmd="-L --compressed -o"
endif

" AUTOCOMMANDS:
augroup quickfixwindow
   au!
   autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
            \   q :cclose<cr>:lclose<cr>
   autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
augroup END

augroup core
   au!
   autocmd Syntax *
            \ if line('$') > 1000 | syntax sync minlines=300 | endif
   autocmd BufNewFile,BufEnter * set cpoptions+=d " NOTE: ctags find the tags file from the current path instead of the path of currect file
   autocmd BufWinLeave * let b:_winview = winsaveview()
   autocmd BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
   autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
   autocmd InsertLeave *
            \ if &paste | setlocal nopaste | echo 'nopaste' | endif |
         \ if &l:diff | diffupdate | endif
   autocmd BufWritePre /tmp/*          setlocal noundofile
   autocmd BufWritePre COMMIT_EDITMSG  setlocal noundofile
   autocmd BufWritePre MERGE_MSG       setlocal noundofile
   autocmd BufWritePre *.tmp           setlocal noundofile
   autocmd BufWritePre *.bak           setlocal noundofile
   autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
augroup END

" startify if no passed argument or all buffers are closed
augroup noargs
   " open startify on start if no argument was passed
   autocmd VimEnter * if argc() == 0 | Startify | endif
augroup END

