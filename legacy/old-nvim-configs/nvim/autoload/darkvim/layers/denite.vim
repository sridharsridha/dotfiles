" denite.vim fuzzyfinder layer for darkvim

function! darkvim#layers#denite#plugins() abort
   let l:plugins = []

   call add(l:plugins, ['Shougo/denite.nvim', {
	    \  'on_cmd':['Denite','DeniteBufferDir','DeniteCursorWord',
	    \            'DeniteProjectDir'],
	    \  'loadconf':1}])

   call add(l:plugins, ['chemzqm/denite-extra', { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['raghur/fruzzy',        { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['neoclide/denite-git',  { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['Shougo/unite-outline', { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['Shougo/neomru.vim',    { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['Shougo/neoyank.vim',   { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['notomo/denite-keymap', { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['rafi/vim-denite-z',    { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['kmnk/denite-dirmark',  { 'on_source':['denite.nvim']}])

   return l:plugins
endfunction

function! darkvim#layers#denite#config() abort
   let g:neoyank#file = g:darkvim_plugin_bundle_dir . 'neoyank'

   call darkvim#mapping#space#group(['b'], 'Buffer')
   call darkvim#mapping#space#group(['b', 'p'], 'Parent-Directory')
   call darkvim#mapping#space#group(['d'], 'Directory')
   call darkvim#mapping#space#group(['f'], 'File')
   call darkvim#mapping#space#group(['j'], 'Jump')
   call darkvim#mapping#space#group(['p'], 'Project')
   call darkvim#mapping#space#group(['q'], 'Quickfix')
   call darkvim#mapping#space#group(['r'], 'Register')
   call darkvim#mapping#space#group(['s'], 'Search')
   call darkvim#mapping#space#group(['t'], 'Tags')
   call darkvim#mapping#space#group(['y'], 'Yank')
   call darkvim#mapping#space#group(['T'], 'Colorscheme')

   " Resume
   call darkvim#mapping#space#group(['r'], 'Resume')
   call darkvim#mapping#space#def('nnoremap', ['r', 'l'], 'Denite -resume', 'resume-fuzzy-finder', 1)

   " Quick access files
   call darkvim#mapping#def('nnoremap <silent><nowait>', '<C-p>', ':Denite file/rec<cr>', 'list-files')

   "Project
   call darkvim#mapping#space#def('nnoremap', ['p', 'f'], 'DeniteProjectDir file/rec', 'list-files', 1)
   call darkvim#mapping#space#def('nnoremap', ['p', 'F'], 'DeniteProjectDir file/rec/noignore', 'list-files-noignore', 1)
   call darkvim#mapping#space#def('nnoremap', ['p', 'd'], 'execute "DeniteProjectDir directory_rec', 'list-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['p', 'D'], 'execute "DeniteProjectDir directory_rec/noignore', 'list-dir-noignore', 1)

   " Files listing
   call darkvim#mapping#space#def('nnoremap', ['f', 'f'], 'Denite file/rec', 'list-files', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', 'F'], 'Denite file/rec/noignore', 'list-files-noignore', 1)

   call darkvim#mapping#space#def('nnoremap', ['f', 'r'], 'Denite file_mru', 'list-recent-files', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', 'm'], 'Denite mark', 'list-marks', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', '?'], 'call call('.string(function('s:denite_tasklist')).', [])', 'list-tasks', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', 'i'], 'call call('. string(function('s:denite_scan_dir')) .', [])', 'scan-files', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', 'I'], 'call call('. string(function('s:denite_scan_dir')) .', [0])', 'scan-files-noignore', 1)

   " Buffers
   call darkvim#mapping#space#def('nnoremap', ['b', 'b'], 'Denite buffer', 'list-buffers', 1)
   call darkvim#mapping#space#def('nnoremap', ['b', 'f'], 'DeniteBufferDir file/rec', 'list-files', 1)
   call darkvim#mapping#space#def('nnoremap', ['b', 'F'], 'DeniteBufferDir file/rec/noignore', 'list-files-noignore', 1)

   call darkvim#mapping#space#def('nnoremap', ['b', 'p', 'f'], 'execute "Denite file/rec:" . expand("%:p:h:h")', 'list-file-parent-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['b', 'p', 'f'], 'execute "Denite file/rec/noignore:" . expand("%:p:h:h")', 'list-files-parent-dir-noignore', 1)
   call darkvim#mapping#space#def('nnoremap', ['b', 'p', 'd'], 'execute "Denite directory_rec:" . expand("%:p:h")', 'list-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['b', 'p', 'd'], 'execute "Denite directory_rec:" . expand("%:p:h:h")', 'list-parent-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['b', 'p', 'D'], 'execute "Denite directory_rec/noignore:" . expand("%:p:h:h")', 'list-parent-dir-noignore', 1)
   call darkvim#mapping#space#def('nnoremap', ['b', 's'], 'DeniteCursorWord line:forward', 'search-word', 1)
   call darkvim#mapping#space#def('vnoremap', ['b', 's'], 'call call('.string(function('s:denite_visual_search')).', ["forward"])', 'search-selection', 1)

   " Directory
   call darkvim#mapping#space#def('nnoremap', ['d', 'f'], 'Denite directory_rec', 'list-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', 'F'], 'Denite directory_rec/noignore', 'list-dir-noignore', 1)

   call darkvim#mapping#space#def('nnoremap', ['d', 'r'], 'Denite directory_mru', 'list-mru-dirs', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', 'z'], 'Denite z', 'list-zoxide-db', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', 'm'], 'Denite dirmark', 'list-dirmark', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', '?'], 'call call('.string(function('s:denite_tasklist')).', ["."])', 'dir-tasklist', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', 's'], 'DeniteCursorWord -no-start-filter -no-empty grep', 'search-cursor-word', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', 'S'], 'Denite -no-start-filter -no-empty grep', 'search-input', 1)

   " Yank
   call darkvim#mapping#space#def('nnoremap', ['y', 'f'], 'Denite neoyank', 'yank-history', 1)

   " Regsiter
   call darkvim#mapping#space#def('nnoremap', ['r', 'f'], 'Denite register', 'register', 1)

   " Jumps
   call darkvim#mapping#space#def('nnoremap', ['j', 'i'], 'Denite outline', 'outline', 1)
   call darkvim#mapping#space#def('nnoremap', ['j', 'f'], 'Denite jump', 'jumplist', 1)
   call darkvim#mapping#space#def('nnoremap', ['j', 'c'], 'Denite change', 'changelist', 1)

   " Search
   call darkvim#mapping#space#def('nnoremap', ['s', 'f'], 'call call('. string(function('s:denite_grep')) .', [1])', 'search', 1)
   call darkvim#mapping#space#def('nnoremap', ['s', 'F'], 'call call('. string(function('s:denite_grep')) .', [0])', 'search-noignore', 1)
   call darkvim#mapping#space#def('nnoremap', ['s', 'i'], 'call call('. string(function('s:denite_grep')) .', [1, 1])', 'search-interactive', 1)
   call darkvim#mapping#space#def('nnoremap', ['s', 'I'], 'call call('. string(function('s:denite_grep')) .', [0, 1])', 'search-interactive-noignore', 1)

   call darkvim#mapping#space#def('nnoremap', ['t', 'f'], 'Denite tag', 'tags', 1)

   " Colorscheme
   call darkvim#mapping#space#def('nnoremap', ['T', 'f'], 'Denite colorscheme', 'colorschemes', 1)

   call darkvim#mapping#space#group(['k'], 'Vim')
   call darkvim#mapping#space#def('nnoremap', ['k', 'l'], 'Denite location_list', 'location-list', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 'f'], 'Denite -post-action=suspend quickfix', 'quickfix', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 'C'], 'Denite command', 'commands', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', '?'], 'Denite help', 'help-tags', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 'k'], 'Denite keymap', 'keymappings', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 's'], 'Denite history:search', 'search-history', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 'c'], 'Denite command_history', 'command-history', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 'f'], 'Denite output:function', 'functions', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 'm'], 'Denite output:messages', 'messages', 1)

   " Note: we need to pass the parent dir of the candidate we want to bookmark
   command -nargs=1 -complete=file DeniteBookmarkAdd
	    \ call darkvim#layers#denite#bookmark_add(<q-args>)
endfunction

function! darkvim#layers#denite#bookmark_add(path) abort
   execute 'Denite dirmark/add -default-action=add -immediately-1 -path=' .
	    \ expand(a:path)
endfunction

function! s:denite_visual_search(direction) abort
   let temp = @s
   norm! gv"sy
   let visual_selection = @s
   let visual_selection = escape(visual_selection, '$+%\.{*|@^')
   let @s = temp
   call denite#start([{'name': 'line', 'args': [a:direction]}],
	    \ {'input': visual_selection})
endfunction

function! s:denite_scan_dir(...) abort
   let narrow_dir = input('Input narrowing directory: ', '', 'file')
   if narrow_dir ==# ''
      return
   endif
   let git_ignore = get(a:, 1, 1)
   let source = git_ignore == 1 ? 'file/rec' : 'file/rec/noignore'
   call denite#start([{'name': source, 'args': [narrow_dir]}])
endfunction

function! s:denite_grep(...) abort
   if !executable('rg')
      echoerr 'ripgrep is not installed or not in  your path.'
      return
   endif
   let l:save_pwd = getcwd()
   lcd %:p:h
   let narrow_dir = input('Target: ', '.', 'file')
   if narrow_dir ==# ''
      return
   endif
   " Don't search gitignored files by default
   let extra_args = ''
   let git_ignore = get(a:, 1, 1)
   if git_ignore == 0
      let extra_args = '--no-ignore-vcs '
   endif
   let filetype = input('Filetype: ', '')
   if filetype ==# ''
      let ft_filter = ''
   else
      let ft_filter = '--type ' . filetype
   endif
   " Allow to run in interactive mode (or require an input pattern)
   let grep_args = [narrow_dir, extra_args . ft_filter]
   let interactive = get(a:, 2, 0)
   if interactive == 1
      call add (grep_args, '!')
   endif
   execute 'lcd ' . l:save_pwd
   call denite#start([{'name': 'grep', 'args': grep_args}],
	    \ {'start_filter': interactive})
endfunction

function! s:denite_tasklist(...) abort
   if a:0 >=1 && a:1 ==# '.'
      let target = a:1
   else
      let target = expand('%')
   endif
   call denite#start([{'name': 'grep',
	    \ 'args': [target, '','TODO:\s|FIXME:\s']}])
endfunction
