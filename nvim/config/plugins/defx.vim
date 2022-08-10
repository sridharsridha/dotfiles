" defx.vim --- defx configuration
scriptencoding utf-8

let g:_darkvim_filetree_show_hidden_files = 1
let g:_darkvim_autoclose_filetree = 0

if get(g:, 'darkvim_filetree_direction', 'left') ==# 'right'
  let s:direction = 'botright'
else
  let s:direction = 'topleft'
endif

" let g:defx_icons_column_length = 4
" let g:defx_icons_mark_icon = '✓'
" let g:defx_icons_parent_icon = ''

call defx#custom#option('_', {
      \ 'split': 'floating',
      \ })

" call defx#custom#column('mark', {
"      \ 'readonly_icon': '',
"      \ 'selected_icon': '',
"      \ })
" call defx#custom#column('indent', { 'indent': '  '})
" call defx#custom#column('icon', {
"      \ 'root_icon': ' ',
"      \ 'directory_icon': '',
"      \ 'opened_icon': '',
"      \ })

" Git
" call defx#custom#column('git', 'indicators', {
"      \ 'Modified'  : '✚',
"      \ 'Staged'    : '●',
"      \ 'Untracked' : '?',
"      \ 'Renamed'   : '➜',
"      \ 'Unmerged'  : 'שּׁ',
"      \ 'Ignored'   : 'ⁱ',
"      \ 'Deleted'   : '✖',
"      \ 'Unknown'   : '?'
"      \ })

call defx#custom#column('filename', {
      \ 'min_width': 23,
      \ 'max_width': -55,
      \ })

" call defx#custom#column('time', {'format': '%Y%m%d %H:%M'})

" Shown only current directory in root
function! Root(path) abort
  return fnamemodify(a:path, ':t') . '/'
endfunction
call defx#custom#source('file', {'root': 'Root'})

" " Devicons
" let g:defx_icons_enable_syntax_highlight = 0
" let g:defx_icons_extensions = {
"      \ 'tex'       : {'icon' : ''},
"      \ 'bib'       : {'icon' : ''},
"      \ 'gitcommit' : {'icon' : ''},
"      \ 'pdf'       : {'icon' : ''},
"      \ 'r'         : {'icon' : 'ﳒ'},
"      \ 'R'         : {'icon' : 'ﳒ'},
"      \ }
" let g:defx_icons_exact_matches = {
"      \ '.gitconfig'    : {'icon' : ''},
"      \ '.gitignore'    : {'icon' : ''},
"      \ 'bashrc'        : {'icon' : ''},
"      \ '.bashrc'       : {'icon' : ''},
"      \ 'bash_profile'  : {'icon' : ''},
"      \ '.bash_profile' : {'icon' : ''},
"      \ }
" let g:defx_icon_exact_dir_matches = {
"      \ '.git'      : {'icon' : ''},
"      \ 'Desktop'   : {'icon' : ''},
"      \ 'Documents' : {'icon' : ''},
"      \ 'Downloads' : {'icon' : ''},
"      \ 'Dropbox'   : {'icon' : ''},
"      \ 'Music'     : {'icon' : ''},
"      \ 'Pictures'  : {'icon' : ''},
"      \ 'Public'    : {'icon' : ''},
"      \ 'Templates' : {'icon' : ''},
"      \ 'Videos'    : {'icon' : ''},
"      \ }
" 
augroup defx_init
  au!
  " Init defx mappings
  autocmd FileType defx call s:defx_settings()
  autocmd FileType defx setlocal relativenumber

  " auto close last defx windows
  autocmd BufEnter * nested if
       \ (!has('vim_starting') && winnr('$') == 1  && g:_darkvim_autoclose_filetree
       \ && &filetype ==# 'defx') |
       \ call s:close_last_defx_windows() | endif
  " Move focus to the next window if current buffer is defx
  autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif
  autocmd User defx-preview setlocal number winblend=4
augroup END

" in this function, we should check if shell terminal still exists,
" then close the terminal job before close vimfiler
function! s:close_last_defx_windows() abort
  if darkvim#layers#is_loaded('shell')
    call darkvim#layers#shell#close_terminal()
  endif
  q
endfunction

function! s:defx_settings()
  " disable this mappings
  nnoremap <silent><buffer> <3-LeftMouse> <Nop>
  nnoremap <silent><buffer> <4-LeftMouse> <Nop>
  nnoremap <silent><buffer> <LeftMouse> <LeftMouse><Home>
  silent! nunmap <buffer> <Space>
  silent! nunmap <buffer> <C-l>
  silent! nunmap <buffer> <C-j>
  silent! nunmap <buffer> E
  silent! nunmap <buffer> gr
  silent! nunmap <buffer> gf
  silent! nunmap <buffer> -
  silent! nunmap <buffer> s

  " Move updating preview
  nnoremap <silent><buffer> j :<C-u>call <SID>defx_update_preview(line('.') == line('$') ? 'gg' : 'j', v:count1)<CR>
  nnoremap <silent><buffer> k :<C-u>call <SID>defx_update_preview(line('.') == 1 ? 'G' : 'k', v:count)<CR>
  " Navigation:
  nnoremap <silent><buffer> <Home> :call cursor(2, 1)<cr>
  nnoremap <silent><buffer> <End>  :call cursor(line('$'), 1)<cr>
  " nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  " nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <Tab> winnr('$') != 1 ?
       \ ':<C-u>wincmd w<CR>' :
       \ ':<C-u>Defx -buffer-name=temp -split=vertical<CR>'
  " Exit with escape key and q, Q
  nnoremap <silent><buffer><expr> <ESC> defx#do_action('quit')
  nnoremap <silent><buffer><expr> q defx#do_action('quit')
  nnoremap <silent><buffer><expr> Q defx#do_action('call', '<SID>defx_quit_all')
  " Edit and open with external program
  nnoremap <silent><buffer><expr> <CR>
       \ defx#is_directory() ? defx#do_action('open_directory') :
       \ defx#do_action('multi', ['drop', 'quit'])
  nnoremap <silent><buffer><expr> l
       \ defx#is_directory() ? defx#do_action('open') :
       \ defx#do_action('multi', ['drop', 'quit'])
  nnoremap <silent><buffer><expr> o defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> <2-LeftMouse>
       \ defx#is_directory() ?
       \     (
       \     defx#is_opened_tree() ?
       \     defx#do_action('close_tree') :
       \     defx#do_action('open_tree')
       \     )
       \ : defx#do_action('drop')
  " Tree editing, opening and closing
  nnoremap <silent><buffer><expr> e
       \ defx#is_directory() ? defx#do_action('open_tree', 'toggle') :
       \ defx#do_action('multi', ['drop', 'quit'])
  nnoremap <silent><buffer><expr> t  defx#do_action('open_tree_recursive')
  nnoremap <silent><buffer><expr> zo defx#do_action('open_tree', 'toggle')
  nnoremap <silent><buffer><expr> zc defx#do_action('close_tree')
  nnoremap <silent><buffer><expr> zr defx#do_action('open_tree', 'recursive:3')
  " Open files in splits
  nnoremap <silent><buffer><expr> st defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
  nnoremap <silent><buffer><expr> sv defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
  nnoremap <silent><buffer><expr> sg defx#do_action('multi', [['drop', 'split'], 'quit'])
  " Copy, move, paste and remove
  nnoremap <silent><buffer><expr> c defx#do_action('copy')
  nnoremap <silent><buffer><expr> m defx#do_action('move')
  nnoremap <silent><buffer><expr> p defx#do_action('paste')
  nnoremap <silent><buffer><expr> X defx#do_action('remove')
  nnoremap <silent><buffer><expr> d defx#do_action('remove_trash')
  " Yank and rename
  nnoremap <silent><buffer><expr> y defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> r defx#do_action('rename')
  " New file and directory
  nnoremap <silent><buffer><expr> F defx#do_action('new_file')
  nnoremap <silent><buffer><expr> N defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> D defx#do_action('new_directory')
  " Move up a directory
  nnoremap <silent><buffer><expr> <BS> defx#do_action('cd' , ['..'])
  nnoremap <silent><buffer><expr> u    defx#do_action('cd' , ['..'])
  nnoremap <silent><buffer><expr> 2u   defx#do_action('cd' , ['../..'])
  nnoremap <silent><buffer><expr> 3u   defx#do_action('cd' , ['../../..'])
  nnoremap <silent><buffer><expr> 4u   defx#do_action('cd' , ['../../../..'])
  " Home directory
  nnoremap <silent><buffer><expr> H defx#do_action('cd')
  " Mark a file
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
  " Toggle hidden files
  nnoremap <silent><buffer><expr> a defx#do_action('toggle_ignored_files')
  " Preview
  nnoremap <silent><buffer><expr> P defx#do_action('preview')
  nnoremap <silent><buffer>       <A-w> <C-w>P
  " Redraw
  nnoremap <silent><buffer><expr> <C-r> defx#do_action('redraw')
  " Toggle sorting from filename to time (with last modified first)
  nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'Time')
  " Toggle columns to show time
  nnoremap <silent><buffer><expr> T defx#do_action('toggle_columns',
       \ 'icons:filename:time')
  nnoremap <silent><buffer><expr> C
       \ defx#do_action('toggle_columns', 'indent:mark:filename:type:size:time')
  " Print current file path
  nnoremap <silent><buffer><expr> <C-g>  defx#do_action('print')
  " Save session
  nnoremap <silent><buffer><expr> se     defx#do_action('save_session')
  " Change directory
  nnoremap <silent><buffer><expr><nowait> \ defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr><nowait> &  defx#do_action('cd', getcwd())
  nnoremap <silent><buffer> ~ :execute 'lcd' . b:defx.paths[0]<CR>
  " Selection
  nnoremap <silent><buffer><expr> *  defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr><nowait> <Space> defx#do_action('toggle_select') . 'j'
  " Resize window (increasing truncated filename)
  nnoremap <silent><buffer><expr> >
       \ defx#do_action('resize', defx#get_context().winwidth + 5)
  nnoremap <silent><buffer><expr> <
       \ defx#do_action('resize', defx#get_context().winwidth - 5)

  " Open new defx buffer
  nnoremap <silent><buffer>       sp
       \ :execute 'Defx -new -split=horizontal -direction= ' . b:defx.paths[0]<CR>
       \ :wincmd p<CR>:execute float2nr(&lines /2) . 'wincmd _ '<CR>

  " Custom Defx Actions
  " smart h/l
  nnoremap <silent><buffer><expr> h       defx#do_action('call', '<SID>defx_smart_h')
  nnoremap <silent><buffer><expr> l       defx#do_action('call', '<SID>defx_smart_l')
  nnoremap <silent><buffer><expr> <Left>  defx#do_action('call', '<SID>defx_smart_h')
  nnoremap <silent><buffer><expr> <Right> defx#do_action('call', '<SID>defx_smart_l')
  " git diff of current file
  nnoremap <silent><buffer><expr> gd
       \ defx#async_action('multi', ['drop', ['call', '<SID>defx_git_diff']])
  " Open file explorer in a new tmux plane
  nnoremap <silent><buffer><expr> gt defx#async_action('call', '<SID>defx_tmux_file_explorer')
  " Quickly toggle defx width
  nnoremap <silent><buffer><expr> w  defx#async_action('call', '<SID>defx_toggle_width')
  " Denite
  if darkvim#layers#is_loaded('denite')
    " History source
    nnoremap <silent><buffer> <C-h> :Denite defx/history<CR>
    " Bookmarks source
    nnoremap <silent><buffer> b     :Denite defx/dirmark<CR>
    nnoremap <silent><buffer><expr> gs  defx#do_action('call', '<SID>defx_grep')
    nnoremap <silent><buffer><expr> gff defx#do_action('call', '<SID>defx_find_files')
    nnoremap <silent><buffer><expr> gfd defx#do_action('call', '<SID>defx_find_dirs')
    nnoremap <silent><buffer><expr> gfp defx#do_action('call', '<SID>defx_find_parents_dirs')
  endif
endfunction

" Helper fnctions
function! s:trim_right(str, trim)
  return substitute(a:str, printf('%s$', a:trim), '', 'g')
endfunction

function! s:get_base_dir(candidate) abort
  if line('.') == 1
    let l:path_mod  = 'h'
  else
    let l:path_mod = isdirectory(a:candidate) ? 'h:h' : 'h'
  endif
  return fnamemodify(a:candidate, ':p:' . l:path_mod)
endfunction

" in this function we should vim-choosewin if possible
function! s:defx_smart_l(_)
  if defx#is_directory()
    call defx#call_action('open_tree')
    normal! j
  else
    let l:filepath = defx#get_candidate()['action__path']
    if tabpagewinnr(tabpagenr(), '$') >= 3    " if there are more than 2 normal windows
      if exists(':ChooseWin') == 2
        ChooseWin
      else
        let l:input = input('ChooseWin No./Cancel(n): ')
        if l:input ==# 'n' | return | endif
        if l:input == winnr() | return | endif
        exec l:input . 'wincmd w'
      endif
      exec 'e' l:filepath
    else
      exec 'wincmd w'
      exec 'e' l:filepath
    endif
  endif
endfunction

function! s:defx_smart_h(_)
  " if cursor line is first line, or in empty dir
  if line('.') ==# 1 || line('$') ==# 1
    return defx#call_action('cd', ['..'])
  endif

  " candidate is opend tree?
  if defx#is_opened_tree()
    return defx#call_action('close_tree')
  endif

  " parent is root?
  let s:candidate = defx#get_candidate()
  let s:parent = fnamemodify(s:candidate['action__path'], s:candidate['is_directory'] ? ':p:h:h' : ':p:h')
  let l:sep = '/'
  if s:trim_right(s:parent, l:sep) == s:trim_right(b:defx.paths[0], l:sep)
    return defx#call_action('cd', ['..'])
  endif

  " move to parent.
  call defx#call_action('search', s:parent)

  " if you want close_tree immediately, enable below line.
  call defx#call_action('close_tree')
endfunction

function! s:defx_git_diff(context) abort
  execute 'vert Gdiffsplit'
endfunction

function! s:defx_find_files(context) abort
  " Find files in parent directory with Denite
  let l:parent = s:get_base_dir(a:context.targets[0])
  silent execute 'wincmd w'
  silent execute 'Denite -default-action=defx file/rec:'.l:parent
endfunction

function! s:defx_find_dirs(context) abort
  " Find files in parent directory with Denite
  let l:parent = s:get_base_dir(a:context.targets[0])
  silent execute 'wincmd w'
  silent execute 'Denite -default-action=defx directory_rec:'.l:parent
endfunction

function! s:defx_find_parents_dirs(context) abort
  " Find all directories in parent directory
  let l:parent = s:get_base_dir(a:context.targets[0])
  silent execute 'wincmd w'
  silent execute 'Denite -default-action=defx ' . 'parent_dirs:'.l:parent
endfunction

function! s:defx_grep(context) abort
  " Grep in parent directory with Denite
  let l:parent = s:get_base_dir(a:context.targets[0])
  silent execute 'wincmd w'
  silent execute 'Denite grep:'.l:parent
endfunction

function! s:defx_toggle_width(context) abort
  " Toggle between defx window width and longest line
  let l:max = 0
  let l:original = a:context['winwidth']
  for l:line in range(1, line('$'))
    let l:len = len(getline(l:line))
    if l:len > l:max
      let l:max = l:len
    endif
  endfor
  execute 'vertical resize ' . (l:max == winwidth('.') ? l:original : l:max)
endfunction

" Open file-explorer split with tmux
function! s:defx_tmux_file_explorer(context) abort
  let l:explorer = darkvim#util#find_file_explorer()
  if empty('$TMUX') || empty(l:explorer)
    return
  endif
  let l:target = a:context['targets'][0]
  let l:parent = fnamemodify(l:target, ':h')
  call darkvim#util#tmux_split_run(l:explorer, l:parent)
endfunction

function! s:defx_quit_all(context) abort
  let l:buffers = filter(range(1, bufnr('$')),
       \ 'getbufvar(v:val, "&filetype") ==# "defx"')
  let l:win_id = -1
  for l:i in l:buffers
    call defx#call_action('quit')
    if l:win_id == -1
      let l:win_id = win_getid()
      wincmd p
    endif
  endfor
  call win_gotoid(l:win_id)
endfunction

function! s:defx_update_preview(dir, lines) abort
  execute 'normal! ' . a:lines . a:dir
  for l:nr in range(1, winnr('$'))
    if getwinvar(l:nr, '&previewwindow') == 1
      call defx#call_action('preview')
      break
    endif
  endfor
endfunction

