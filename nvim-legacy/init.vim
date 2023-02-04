set nocompatible

" Load local config
if filereadable(expand('~/.config/nvim/init.local.vim'))
   source ~/.config/nvim/init.local.vim
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

" Git
Plug 'tpope/vim-fugitive'                               " git support
Plug 'tpope/vim-repeat'
Plug 'rhysd/accelerated-jk'
" Operator for deleting or adding brackets and quotes 'saiw(' 'sdb' 'sd(' 'srb"' 'sr("'
Plug 'machakann/vim-sandwich'
" Search and Files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fzf itself
Plug 'junegunn/fzf.vim', { 'on': ['Files', 'FZF']}                                " fuzzy search integration
" QuickFix
Plug 'yssl/QFEnter'
Plug 'milkypostman/vim-togglelist', { 'on': ['QToggle', 'LToggle']}
" Visuals
Plug 'mhinz/vim-startify'                               " cool start up screen
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
" Code editing helpers
Plug 'tpope/vim-commentary'                             " better commenting
Plug 'Raimondi/delimitMate'
Plug 'ntpeters/vim-better-whitespace'
Plug 'AndrewRadev/switch.vim'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
"Documentation
Plug 'sbdchd/neoformat'
Plug 'tyru/open-browser.vim'
Plug 'gauteh/vim-cppman'
Plug 'bfrg/vim-cpp-modern', {'for': 'cpp'}
" Tmux navigation support
Plug 'christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'
" Colorscheme
Plug 'morhetz/gruvbox'
" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" General:
set path+=**
set magic
set mouse=a
set wrap
set timeoutlen=500
set clipboard=unnamedplus
set completeopt=menuone,noinsert,noselect,preview
set showmatch

" WildMenu:
" The first tab completes as much as it can, second tab displays a list of
" options, and the third tab will present a list that allows you to scroll
" through and select filenames beginning with that prefix.
set wildmode=longest,list,full
set wildignorecase

" Directories:
function s:create_cache_directory(dir)
   if finddir(a:dir) ==# ''
      silent call mkdir(a:dir, 'p', 0700)
   endif
endfunction
" let g:data_dir = $HOME . '/.cache/nvim/'
" call s:create_cache_directory(g:data_dir . '.bkp')
" call s:create_cache_directory(g:data_dir . '.swp')
" call s:create_cache_directory(g:data_dir . '.undo')
" call s:create_cache_directory(g:data_dir . '.view')
" set undodir=$HOME/.cache/nvim/.undo
" set backupdir=$HOME/.cache/nvim/.bkp
" set directory=$HOME/.cache/nvim/.swp
" set viewdir=$HOME/.cache/nvim/.view
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
set number relativenumber
set nofoldenable
set conceallevel=2 concealcursor=niv " For snippet_complete marker
set lazyredraw                       " Don't redraw while executing macros.
set showtabline=2
set termguicolors

" Accelerated jk:
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" PLUGIN CONFIGURATIONS:

" Mapping Hints:
" let g:which_key_map =  {}
" let g:which_key_map_visual =  {}
" let g:which_key_timeout = 500
" nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
" vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
" augroup vim_which_key_custom
"    autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map', 'n') | call which_key#register('<Space>', 'g:which_key_map_visual', 'v')
"    autocmd! FileType which_key
"    autocmd  FileType which_key set laststatus=0 noshowmode noruler
"             \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" augroup END

" Package Manager:
" let g:which_key_map.p = {
"          \ 'name' : '+plugins' ,
"          \ 'u' : [':PlugUpdate'     , 'update'],
"          \ 'c' : [':PlugClean'     , 'clean'],
"          \ }
augroup vim_plug_custom
   " Automatically install missing plugins on startup
   autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif
augroup END

" FuzzyFinder:
let g:fzf_layout = { 'down': '~100%' }
noremap <C-p> :Files<CR>
noremap <Space>ff :Rg<CR>
noremap <Space>fl :BLines<CR>
noremap <Space>fb :Buffers<CR>

" Statusline:
colorscheme gruvbox
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:gruvbox_italic = 1
let g:gruvbox_hls_cursor = 'purple'
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 1

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

" Switch Values:
let g:switch_mapping = '-'
let g:switch_custom_definitions =
         \ [
         \   ['eslint-enable', 'eslint-disable'],
         \   ['TRUE', 'FALSE']
         \ ]
" augroup SwitchJavaScript
"    autocmd FileType javascript let b:switch_custom_definitions =
"             \  [
"             \    {
"             \     '="\(.\{-}\)"':                    '={`\1`}',
"             \     '={`\(.\{-}\)`}':                  '="\1"',
"             \    },
"             \    {
"             \     '\%(=\)\@!''\(.\{-}\)''':          '"\1"',
"             \     '\%(=\)\@!"\(.\{-}\)"':            '`\1`',
"             \     '\%(=\)\@!`\%(\$\)\@!\(.\{-}\)`':  '`${\1}`',
"             \     '\%(=\)\@!`${\(.\{-}\)}`':         '''\1''',
"             \    }
"             \  ]
" augroup END

" ToggleList:
let g:toggle_list_no_mappings = 0
command! QToggle call ToggleQuickfixList()
command! LToggle call ToggleLocationList()

" OpenBrowser:
let g:openbrowser_search_engines = extend(
\ get(g:, 'openbrowser_search_engines', {}),
\ {
\   'cppreference': 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={query}',
\ },
\ 'keep'
\)
command! OpenBrowserCppRef call openbrowser#smart_search(expand('<cword>'), "cppreference")
let g:which_key_map.o = {
         \ 'name' : '+open',
         \ 'c' : ['OpenBrowserCppRef', 'cppreference' ],
         \}

" Fswitch:
noremap <Space>aa :FSHere<CR>
noremap <Space>ah :FSSplitLeft<CR>
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

" GLOBAL MAPPINGS:
" Use jk switch to normal mode
" Press i to enter insert mode, and ii to exit insert mode.
inoremap ii <Esc>
inoremap jk <Esc>
inoremap kj <Esc>
vnoremap jk <Esc>
vnoremap kj <Esc>
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
" vnoremap j gj
" vnoremap k gk
" Start an external command with a single bang
nnoremap !  :!
" Search result navigation
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
" use up down on pum
imap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
imap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
imap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
imap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
" Buffer movement
" nmap <Tab> :bnext<CR>
" nmap <S-Tab> :bprevious<CR>

" new line in normal mode and back
" map <Enter> o<ESC>
" map <S-Enter> O<ESC>
noremap q :q<CR>
noremap <C-q> :q!<CR>
" use a different register for delete and paste
" nnoremap d "_d
" vnoremap d "_d
" vnoremap p "_dP
" nnoremap x "_x
" " emulate windows copy, cut behavior
" vnoremap <LeftRelease> "+y<LeftRelease>
" vnoremap <C-c> "+y<CR>
" vnoremap <C-x> "+d<CR>
" disable hl with 2 esc
noremap <silent><esc> <esc>:noh<CR><esc>
noremap sv <C-w>v
noremap sg <C-w>s
noremap s= <C-w>=
noremap sb :Buffers<CR>
noremap sw :Windows<CR>
noremap sn :bnext<CR>
noremap sp :bprevious<CR>

noremap tp :setlocal invpaste<CR>
noremap th :setlocal invhlsearch<CR>
noremap tq :QToggle<CR>
noremap tl :LToggle<CR>
noremap tw :setlocal invwrap<CR>

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
   autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
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

" fzf if passed argument is a folder
augroup folderarg
   " change working directory to passed directory
   autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | execute 'cd' fnameescape(argv()[0])  | endif
   " start startify (fallback if fzf is closed)
   autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | Startify  | endif
   " start fzf on passed directory
   autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | execute 'Files ' fnameescape(argv()[0]) | endif
augroup END

" Needed to load local mappings from local vimrc
call LocalMappings()
