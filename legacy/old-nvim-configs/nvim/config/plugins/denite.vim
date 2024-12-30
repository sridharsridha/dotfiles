scriptencoding utf-8

" Don't reload Denite twice (on vimrc reload)
if exists('*denite#start')
  finish
endif

" " Denite general settings
call denite#custom#option('_', {
      \ 'auto_resize': v:true,
      \ 'statusline': v:false,
      \ 'start_filter': v:true,
      \ 'filter_updatetime': 100,
      \ 'source_names': 'short',
      \ 'winheight': 15,
      \ 'winminheight': -1,
      \ 'reversed': v:true,
      \ 'prompt': '$ ',
      \ 'match_highlight': v:false,
      \ 'highlight_prompt': 'Function',
      \ 'highlight_matched_char': 'Question',
      \ 'highlight_matched_range': 'None',
      \ 'highlight_filter_background': 'NvimFloat',
      \ 'highlight_window_background': 'Todo',
      \ })


if exists('*nvim_open_win')
  call denite#custom#option('_', {
        \ 'split': 'floating',
        \ 'floating_preview': v:true,
        \ 'filter_split_direction': 'floating',
        \ })
endif

" Allow customizable window positions: top, bottom, center (default)
function! s:denite_resize(position)
  if a:position ==# 'top'
    call denite#custom#option('_', {
          \ 'winwidth': float2nr(&columns - 2 * (&columns / 100)),
          \ 'wincol': float2nr(&columns / 100),
          \ 'winrow': float2nr(&lines / 25),
          \ })
  elseif a:position ==# 'bottom'
    call denite#custom#option('_', {
          \ 'winwidth': float2nr(&columns - 2 * (&columns / 50)),
          \ 'wincol': float2nr(&columns / 50),
          \ 'winrow': float2nr((&lines - 2) - (&lines / 3)),
          \ })
  else
    call denite#custom#option('_', {
          \ 'winwidth': float2nr(&columns - 2 * (&columns / 20)),
          \ 'wincol': float2nr(&columns / 20),
          \ })
    " Use Denite default, which is centered.
  endif
endfunction

" Set Denite's window position
let g:denite_position = get(g:, 'denite_position', '')
call s:denite_resize(g:denite_position)

" MATCHERS
" Fruzzy matcher
" let g:fruzzy#usenative = 0
" let g:fruzzy#sortonempty = 0
" call denite#custom#source('_', 'matchers', ['matcher/fruzzy',
"      \ 'matcher/ignore_globs'])
" call denite#custom#source('tag', 'matchers', ['matcher/substring'])
" call denite#custom#source('line', 'matchers', ['matcher/regexp'])
" call denite#custom#source('default', 'sorters', ['sorter/rank'])
call denite#custom#source('z', 'sorters', ['sorter_z'])

" Devicon converter
call denite#custom#source('file/rec,file/rec/noignore,buffer,fast_file_mru,'
      \ .'directory_rec,directory_rec/noignore,parent_dirs,grep,z',
      \ 'converters', ['converter/devicons'])
" Ignore some files and directories
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ ['.git/', '__pycache__/', 'venv/',  'tmp/', 'doc/', 'man://*'])
" Buffer source settings
call denite#custom#var('buffer', 'date_format', '')

call denite#custom#alias('source', 'file/git', 'file/rec')
call denite#custom#var('file/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])

" Neomru
let g:neomru#file_mru_limit = 750
let g:neomru#time_format = ''
let g:neomru#do_validate = 1
let g:neomru#update_interval = 300

" Use fd for file_rec and ripgrep for grep
if executable('fd')
  call denite#custom#var('file/rec', 'command',
        \ ['fd', '--type', 'f', '--follow', '--hidden', '--exclude', '.git',
        \ ''])
  call denite#custom#var('directory_rec', 'command',
        \ ['fd', '--type', 'd', '--follow', '--hidden', '--exclude', '.git',
        \ ''])
  " Define alias that don't ignore vcs files
  call denite#custom#alias('source', 'file/rec/noignore', 'file/rec')
  call denite#custom#var('file/rec/noignore', 'command',
        \ ['fd', '--type', 'f', '--follow', '--hidden', '--exclude', '.git',
        \ '--no-ignore-vcs', ''])
  call denite#custom#alias('source', 'directory_rec/noignore',
        \ 'directory_rec')
  call denite#custom#var('directory_rec/noignore', 'command',
        \ ['fd', '--type', 'd', '--follow', '--hidden', '--exclude', '.git',
        \ '--no-ignore-vcs', ''])
endif

" Bookmarks source (dirmark)
call g:dirmark#set_data_directory_path(g:darkvim_plugin_bundle_dir . '/plugins/denite/denite-dirmark')

" FIND and GREP COMMANDS
if executable('rg')
  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'default_opts',
        \ ['--smart-case', '--vimgrep', '--no-heading'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
elseif executable('ag')
  " Setup ignore patterns in your .agignore file!
  " https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage
  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'default_opts',
        \ [ '--skip-vcs-ignores', '--vimgrep', '--smart-case', '--hidden' ])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
endif

function! s:DeniteMoveCursorCandidateWindow(dir, lines, mode) abort
  " noautocmd is needed to preserve proper cursorline highlight
  if a:mode ==# 'filter'
    noautocmd call win_gotoid(win_findbuf(g:denite#_filter_parent)[0])
  endif
  execute 'normal! ' . a:lines . a:dir
  for l:nr in range(1, winnr('$'))
    if getwinvar(l:nr, '&previewwindow') == 1
      call denite#call_map('do_action', 'preview')
      break
    endif
  endfor
  if a:mode ==# 'filter'
    noautocmd call win_gotoid(g:denite#_filter_winid)
    startinsert!
  endif
endfunction

" Define mappings
augroup darkvim_layer_denite
  autocmd!
  autocmd FileType denite call s:denite_settings()
  autocmd FileType denite-filter call s:denite_filter_settings()
  autocmd User denite-preview call s:denite_preview()

  autocmd FileType denite setlocal signcolumn=no cursorline
  autocmd WinEnter * if &filetype ==# 'denite'
        \ |   highlight! link CursorLine CursorLineNr
        \ | endif

  autocmd FileType denite-filter setlocal nocursorline
  autocmd User denite-preview setlocal number winblend=0
  autocmd VimResized * call s:denite_resize(g:denite_position)
augroup END

function! s:denite_settings() abort
  " Denite buffer
  nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  " Actions
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer> j :<C-u>call <SID>DeniteMoveCursorCandidateWindow('j', v:count1, 'normal')<CR>
  nnoremap <silent><buffer> <C-n> :<C-u>call <SID>DeniteMoveCursorCandidateWindow('j', v:count1, 'normal')<CR>
  nnoremap <silent><buffer> k :<C-u>call <SID>DeniteMoveCursorCandidateWindow('k', v:count1, 'normal')<CR>
  nnoremap <silent><buffer> <C-k> k
  nnoremap <silent><buffer> <C-j> j
  nnoremap <silent><buffer> <C-p> :<C-u>call <SID>DeniteMoveCursorCandidateWindow('k', v:count1, 'normal')<CR>
  nnoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-s> denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr>  st   denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr>  sv   denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr>  sg   denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> <C-r> denite#do_map('redraw')
  nnoremap <silent><buffer><expr> <C-x> denite#do_map('choose_action')
  nnoremap <silent><buffer><expr>  d    denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> <C-y> denite#do_map('do_action', 'yank')
  nnoremap <silent><buffer><expr>  yy   denite#do_map('do_action', 'yank')
  nnoremap <silent><buffer> <Tab> :call <SID>denite_tab_action()<CR>
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select') . 'k'
  nnoremap <silent><buffer><expr> <C-Space> denite#do_map('toggle_select') . 'k'
  nnoremap <silent><buffer><expr> <A-v> denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer> <A-w> <C-w>P
  nnoremap <silent><buffer><expr> <A-u> denite#do_map('restore_sources')
  nnoremap <silent><buffer><expr> <C-q> denite#do_map('do_action', 'quickfix')
  nnoremap <silent><buffer> <A-q> :call <SID>denite_quickfix_all()<CR>
  " Custom actions
  nnoremap <silent><buffer><expr> <A-j> denite#do_map('do_action', 'scroll_preview_down')
  nnoremap <silent><buffer><expr> <A-k> denite#do_map('do_action', 'scroll_preview_up')
  nnoremap <silent><buffer><expr> <A-f> denite#do_map('do_action', 'defx')
  nnoremap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'candidate_file_rec')
  nnoremap <silent><buffer><expr> <A-c> denite#do_map('do_action', 'candidate_directory_rec')
  nnoremap <silent><buffer><expr> <A-p> denite#do_map('do_action', 'candidate_parent_dir')
endfunction

" Denite-preview window settings
function! s:denite_preview() abort
  " Clear indents
  if exists('*indent_guides#clear_matches')
    call indent_guides#clear_matches()
  endif
endfunction

" Denite Filter window key mappings
function! s:denite_filter_settings() abort
  " Denite filter buffer
  inoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
  inoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  imap <buffer> <C-e> <Plug>(denite_filter_quit)
  imap <buffer> <C-h> <C-o>h
  inoremap <silent><buffer> <C-k> <Esc><C-w>p
  inoremap <silent><buffer> <C-j> <Esc><C-w>p
  inoremap <silent><buffer> jk    <Esc><C-w>p
  nnoremap <silent><buffer> jk    <C-w>p

  " Actions
  inoremap <silent><buffer> <C-j>
        \ <Esc>:call <SID>DeniteMoveCursorCandidateWindow('j', 1, 'filter')<CR>
  inoremap <silent><buffer> <C-n>
        \ <Esc>:call <SID>DeniteMoveCursorCandidateWindow('j', 1, 'filter')<CR>
  inoremap <silent><buffer> <C-k>
        \ <Esc>:call <SID>DeniteMoveCursorCandidateWindow('k', 1, 'filter')<CR>
  inoremap <silent><buffer> <C-p>
        \ <Esc>:call <SID>DeniteMoveCursorCandidateWindow('k', 1, 'filter')<CR>
  inoremap <silent><buffer> <C-b>
        \ <Esc>:call <SID>DeniteMoveCursorCandidateWindow('k', 12, 'filter')<CR>
  inoremap <silent><buffer> <C-f>
        \ <Esc>:call <SID>DeniteMoveCursorCandidateWindow('j', 12, 'filter')<CR>

  inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-s> denite#do_map('do_action', 'split')
  inoremap <silent><buffer><expr> <C-g> denite#do_map('do_action', 'split')
  inoremap <silent><buffer><expr> <C-r> denite#do_map('redraw')
  inoremap <silent><buffer><expr> <C-x> denite#do_map('choose_action')
  inoremap <silent><buffer><expr> <C-y> denite#do_map('do_action', 'yank')
  inoremap <silent><buffer> <Tab> <ESC>:call <SID>denite_tab_action()<CR>
  inoremap <silent><buffer> <C-Space>
        \ <ESC>:call denite#call_map('toggle_select')<CR><C-w>p
        \ :call cursor(line('.')-1, 0)<CR><C-w>pA
  inoremap <silent><buffer><expr> <A-v> denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> <A-v> denite#do_map('do_action', 'preview')
  inoremap <silent><buffer>       <A-w> <Esc><C-w>P
  inoremap <silent><buffer><expr> <A-u> denite#do_map('restore_sources')
  inoremap <silent><buffer><expr> <C-q> denite#do_map('do_action', 'quickfix')
  inoremap <silent><buffer>       <A-q> <ESC>:call <SID>denite_quickfix_all()<CR>
  " Custom actions
  inoremap <silent><buffer><expr> <A-j> denite#do_map('do_action', 'scroll_preview_down')
  inoremap <silent><buffer><expr> <A-k> denite#do_map('do_action', 'scroll_preview_up')
  inoremap <silent><buffer><expr> <A-f> denite#do_map('do_action', 'defx')
  inoremap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'candidate_file_rec')
  inoremap <silent><buffer><expr> <A-c> denite#do_map('do_action', 'candidate_directory_rec')
  inoremap <silent><buffer><expr> <A-p> denite#do_map('do_action', 'candidate_parent_dir')
endfunction

" Custom actions
function! s:my_split(context)
  let split_action = 'vsplit'
  if winwidth(winnr('#')) <= 2 * (&textwidth ? &textwidth : 80)
    let split_action = 'split'
  endif
  call denite#do_action(a:context, split_action, a:context['targets'])
endfunction
function! s:defx_open(context)
  let path = a:context['targets'][0]['action__path']
  let file = fnamemodify(path, ':p')
  let file_search = filereadable(expand(file)) ? ' -search=' . file : ''
  let dir = denite#util#path2directory(path)
  if &filetype ==# 'defx'
    call defx#call_action('cd', [dir])
    call defx#call_action('search', [file])
  else
    execute('Defx ' . dir . file_search)
  endif
endfunction
function! s:defx_preview(context)
  let path = a:context['targets'][0]['action__path']
  let dir = denite#util#path2directory(path)
  let file = fnamemodify(path, ':p')
  let file_search = filereadable(expand(file)) ? ' -search=' . file : ''

  let has_preview_win = 0
  let defx_path = 0
  for nr in range(1, winnr('$'))
    if getwinvar(nr, '&previewwindow') == 1
      let has_preview_win = 1
      let defx_var = getbufvar(winbufnr(nr), 'defx')
      let defx_path =  defx_var.paths[0]
    endif
  endfor
  if has_preview_win == 1 && defx_path ==# (dir . '/')
    call defx#custom#column('filename', {'min_width': 23, 'max_width': -55})
    pclose!
    return
  endif

  let pos = win_screenpos(win_getid())
  let win_row = pos[0] - 1
  let win_col = (pos[1] - 1) + winwidth(0) - a:context.preview_width

  execute 'silent rightbelow vertical pedit! defx_tmp'
  wincmd P
  silent! setlocal nobuflisted
  call nvim_win_set_config(win_getid(), {
        \ 'relative': 'editor',
        \ 'row': win_row,
        \ 'col': win_col,
        \ 'width': a:context.preview_width,
        \ 'height': a:context.preview_height,
        \ })
  let fn_width = 45
  call defx#custom#column('filename',
        \ {'min_width': fn_width, 'max_width': fn_width })
  execute 'Defx -no-show-ignored-files -new -split=no ' .
        \ '-ignored-files=.*,__pycache__ ' .
        \ '-auto-recursive-level=1 ' .  dir . file_search
  call defx#call_action('open_tree', 'toggle')
  silent! setlocal norelativenumber nonumber
  doautocmd User denite-preview
  wincmd p
endfunction
function! s:candidate_file_rec(context)
  let path = a:context['targets'][0]['action__path']
  let narrow_dir = denite#util#path2directory(path)
  let sources_queue = a:context['sources_queue'] + [[
        \ {'name': 'file/rec/noignore', 'args': [narrow_dir]},
        \ ]]
  return {'sources_queue': sources_queue}
endfunction
function! s:candidate_directory_rec(context)
  let path = a:context['targets'][0]['action__path']
  let narrow_dir = denite#util#path2directory(path)
  let sources_queue = a:context['sources_queue'] + [[
        \ {'name': 'directory_rec/noignore', 'args': [narrow_dir]},
        \ ]]
  return {'sources_queue': sources_queue}
endfunction
function! s:candidate_parent_dir(context)
  let path = a:context['targets'][0]['action__path']
  let narrow_dir = denite#util#path2directory(path)
  let sources_queue = a:context['sources_queue'] + [[
        \ {'name': 'parent_dirs', 'args': [narrow_dir]},
        \ ]]
  return {'sources_queue': sources_queue}
endfunction
function! s:scroll_preview_down(context)
  wincmd P
  execute 'normal! 10j'
  wincmd p
endfunction
function! s:scroll_preview_up(context)
  wincmd P
  execute 'normal! 10k'
  wincmd p
endfunction
function! s:yank_commit(context)
  let candidate = a:context['targets'][0]['word']
  let commit_hash = matchstr(candidate, '*\s\+\zs\w*\ze\s-')
  call setreg('+', commit_hash)
endfunction
function! s:denite_quickfix_all()
  call denite#call_map('toggle_select_all')
  call denite#call_map('do_action', 'quickfix')
endfunction
function! s:denite_tab_action()
  let source_name = b:denite_statusline.sources
  if match(source_name, '^history') != -1
    " Edit action in history search source is called feedkeys
    call denite#call_map('do_action', 'feedkeys')
  else
    call denite#call_map('do_action', 'open')
  endif
endfunction
call denite#custom#action('buffer,directory,file', 'context_split',
      \ function('s:my_split'))
call denite#custom#action('buffer,directory,file,openable,dirmark', 'defx',
      \ function('s:defx_open'))
call denite#custom#action('directory,directory_rec,directory_rec/noignore,' .
      \'dirmark', 'preview', function('s:defx_preview'), {'is_quit': 0})
call denite#custom#action('buffer,directory,file,openable,dirmark',
      \ 'candidate_file_rec', function('s:candidate_file_rec'))
call denite#custom#action('buffer,directory,file,openable,dirmark',
      \ 'candidate_directory_rec', function('s:candidate_directory_rec'))
call denite#custom#action('buffer,directory,file,openable,dirmark',
      \ 'candidate_parent_dir', function('s:candidate_parent_dir'))
call denite#custom#action('file', 'narrow',
      \ {context -> denite#do_action(context, 'open', context['targets'])})
call denite#custom#action('buffer,directory,file,openable,dirmark,gitlog',
      \ 'scroll_preview_down', function('s:scroll_preview_down'),
      \ {'is_quit': 0})
call denite#custom#action('buffer,directory,file,openable,dirmark,gitlog',
      \ 'scroll_preview_up', function('s:scroll_preview_up'),
      \ {'is_quit': 0})
call denite#custom#action('gitlog', 'yank', function('s:yank_commit'))

" Define default actions (don't do this in mapping definitions because it will
" overwrite any other override)
call denite#custom#source('directory_rec,directory_rec/noignore,parent_dirs,' .
      \ 'z,dirmark', 'default_action', 'candidate_file_rec')
call denite#custom#source('dein', 'default_action', 'defx')
