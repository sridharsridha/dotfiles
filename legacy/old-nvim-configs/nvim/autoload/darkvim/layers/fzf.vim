function! darkvim#layers#fzf#plugins() abort
	let l:plugins = []

	" Fzf fuzzy finder support for vim
	call add(l:plugins, ['junegunn/fzf'])
	call add(l:plugins, ['junegunn/fzf.vim', {
				\ 'depends' : ['fzf'],
				\ 'on_cmd' : darkvim#util#prefix('FZF', [
					\ '', 'Buffers', 'Files', 'Rg', 'Lines', 'Marks', 'History', 'Commands',
					\ 'Maps', "Helptags", 'Locate', 'Windows', 'BTags', 'Tags', 'Colors']),
					\ }])

	" Fzf yank source
	call add(l:plugins, ['Shougo/neoyank.vim'])
	call add(l:plugins, ['justinhoward/fzf-neoyank', {
				\ 'depends' : ['neoyank'],
				\ 'on_cmd' : darkvim#util#prefix('FZFNeoyank', ['', 'Selection']),
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#fzf#config() abort
	let g:neoyank#file = g:darkvim_plugin_bundle_dir . 'neoyank'
	let g:fzf_command_prefix = 'FZF'

	let g:fzf_action = {
				\ 'ctrl-q': function('darkvim#layers#fzf#build_quickfix_list'),
				\ 'ctrl-t': 'tab split',
				\ 'ctrl-g': 'split',
				\ 'ctrl-v': 'vsplit' }

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

	" Quick access files
	call darkvim#mapping#def('nnoremap <silent><nowait>', '<C-p>', ':FZF<cr>', 'list-files')

	"Project
	call darkvim#mapping#space#def('nnoremap', ['p', 'f'], 'execute "FZFFiles " . FindRootDirectory()', 'list-files', 1)
	call darkvim#mapping#space#def('nnoremap', ['p', 'd'], 'execute "FZFDirectory " . FindRootDirectory()', 'list-dir', 1)

	" Files listing
	call darkvim#mapping#space#def('nnoremap', ['f', 'f'], 'FZFFiles', 'list-files', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'r'], 'FZFHistory', 'list-recent-files', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'm'], 'FZFMarks', 'list-marks', 1)

	" Buffers
	call darkvim#mapping#space#def('nnoremap', ['b', 'b'], 'FZFBuffers', 'list-buffers', 1)
	call darkvim#mapping#space#def('nnoremap', ['b', 'f'], 'execute "FZFFiles ". expand("%:p:h")', 'list-files', 1)

	call darkvim#mapping#space#def('nnoremap', ['b', 'd'], 'execute "FZFDirectory " . expand("%:p:h")', 'list-dir', 1)
	call darkvim#mapping#space#def('nnoremap', ['b', 'p', 'f'], 'execute "FZFFiles" . expand("%:p:h:h")', 'list-file-parent-dir', 1)
	call darkvim#mapping#space#def('nnoremap', ['b', 'p', 'd'], 'execute "FZFDirectory " . expand("%:p:h:h")', 'list-parent-dir', 1)
	call darkvim#mapping#space#def('nnoremap', ['b', 's'], 'FZFLines', 'search-line', 1)
	call darkvim#mapping#space#def('vnoremap', ['b', 's'], '<Esc>:FZFLines <C-R>=darkvim#util#visual_selection()<CR><CR>', 'search-selection', 0)
	call darkvim#mapping#space#def('nnoremap', ['b', 'w'], 'execute "FZFLines " . expand("<cword>")', 'search-word', 1)

	" Directory
	call darkvim#mapping#space#def('nnoremap', ['d', 'f'], 'FZFDirectory', 'list-dir', 1)

	" Yank
	call darkvim#mapping#space#def('nnoremap', ['y', 'f'], 'FZFNeoyank', 'yank-history', 1)

	" Regsiter
	call darkvim#mapping#space#def('nnoremap', ['r', 'f'], 'FZFRegister', 'register', 1)


	" Jumps
	call darkvim#mapping#space#def('nnoremap', ['j', 'i'], 'FZFOutline', 'outline', 1)
	call darkvim#mapping#space#def('nnoremap', ['j', 'f'], 'FZFJumps', 'jumplist', 1)
	call darkvim#mapping#space#def('nnoremap', ['j', 'c'], 'FZFChanges', 'changelist', 1)

	" Search
	call darkvim#mapping#space#def('nnoremap', ['s', 'f'], 'FZFRg', 'search', 1)
	call darkvim#mapping#space#def('vnoremap', ['s', 'f'], '<Esc>:FZFRg <C-R>=darkvim#util#visual_selection()<CR><CR>', 'search-selection', 0)
	call darkvim#mapping#space#def('nnoremap', ['s', 'F'], 'execute "FZFRg " . expand("<cword>")', 'search-cursor-word', 1)

	call darkvim#mapping#space#def('nnoremap', ['t', 'f'], 'FZFTags', 'tags', 1)

	" Colorscheme
	call darkvim#mapping#space#def('nnoremap', ['T', 'f'], 'FZFColors', 'colorschemes', 1)

	call darkvim#mapping#space#group(['k'], 'Vim')
	call darkvim#mapping#space#def('nnoremap', ['k', 'l'], 'FZFLocationList', 'location-list', 1)
	call darkvim#mapping#space#def('nnoremap', ['k', 'f'], 'FZFQuickfix', 'quickfix', 1)
	call darkvim#mapping#space#def('nnoremap', ['k', 'C'], 'FZFCommands', 'commands', 1)
	call darkvim#mapping#space#def('nnoremap', ['k', '?'], 'FZFHelptags', 'help-tags', 1)
	call darkvim#mapping#space#def('nnoremap', ['k', 'k'], 'FZFMaps', 'keymappings', 1)
	call darkvim#mapping#space#def('nnoremap', ['k', 's'], 'FZFHistory/', 'search-history', 1)
	call darkvim#mapping#space#def('nnoremap', ['k', 'c'], 'FZFHistory:', 'command-history', 1)
	call darkvim#mapping#space#def('nnoremap', ['k', 'm'], 'FZFMessages', 'messages', 1)
endfunction

command! FZFJumps call <SID>jumps()
function! s:bufopen(e) abort
	let l:list = split(a:e)
	if len(l:list) < 4
		return
	endif

	let [l:linenr, l:col, l:file_text] = [l:list[1], l:list[2]+1, join(l:list[3:])]
	let l:lines = getbufline(l:file_text, l:linenr)
	let l:path = l:file_text
	if empty(l:lines)
		if stridx(join(split(getline(l:linenr))), l:file_text) == 0
			let l:lines = [l:file_text]
			let l:path = bufname('%')
		elseif filereadable(l:path)
			let l:lines = ['buffer unloaded']
		else
			" Skip.
			return
		endif
	endif

	exe 'e '  . l:path
	call cursor(l:linenr, l:col)
endfunction
function! s:jumps() abort
	let s:source = 'jumps'
	function! s:jumplist() abort
		return split(call('execute', [ 'jumps' ]), '\n')[1:]
	endfunction
	call fzf#run(fzf#wrap('jumps', {
				\   'source':  reverse(<sid>jumplist()),
				\   'sink':    function('s:bufopen'),
				\   'options': '+m',
				\ }))
endfunction

command! FZFMessages call <SID>message()
function! s:yankmessage(e) abort
	let @" = a:e
	echohl ModeMsg
	echo 'Yanked'
	echohl None
endfunction
function! s:message() abort
	let s:source = 'message'
	function! s:messagelist() abort
		return split(call('execute', ['messages']), '\n')
	endfunction
	call fzf#run(fzf#wrap('messages', {
				\   'source':  reverse(<sid>messagelist()),
				\   'sink':    function('s:yankmessage'),
				\   'options': '+m',
				\ }))
endfunction

command! FZFQuickfix call s:quickfix()
function! s:open_quickfix_item(e) abort
	let l:line = a:e
	let l:filename = fnameescape(split(l:line, ':\d\+:')[0])
	let l:linenr = matchstr(l:line, ':\d\+:')[1:-2]
	let l:colum = matchstr(l:line, '\(:\d\+\)\@<=:\d\+:')[1:-2]
	exe 'e ' . l:filename
	call cursor(l:linenr, l:colum)
endfunction
function! s:quickfix_to_grep(v) abort
	return bufname(a:v.bufnr) . ':' . a:v.lnum . ':' . a:v.col . ':' . a:v.text
endfunction
function! s:quickfix() abort
	let s:source = 'quickfix'
	function! s:quickfix_list() abort
		return map(getqflist(), 's:quickfix_to_grep(v:val)')
	endfunction
	call fzf#run(fzf#wrap('quickfix', {
				\ 'source':  reverse(<sid>quickfix_list()),
				\ 'sink':    function('s:open_quickfix_item'),
				\ 'options': '--reverse',
				\ }))
endfunction
command! FZFLocationList call s:location_list()
function! s:location_list_to_grep(v) abort
	return bufname(a:v.bufnr) . ':' . a:v.lnum . ':' . a:v.col . ':' . a:v.text
endfunction
function! s:open_location_item(e) abort
	let l:line = a:e
	let l:filename = fnameescape(split(l:line, ':\d\+:')[0])
	let l:linenr = matchstr(l:line, ':\d\+:')[1:-2]
	let l:colum = matchstr(l:line, '\(:\d\+\)\@<=:\d\+:')[1:-2]
	exe 'e ' . l:filename
	call cursor(l:linenr, l:colum)
endfunction
function! s:location_list() abort
	let s:source = 'location_list'
	function! s:get_location_list() abort
		return map(getloclist(0), 's:location_list_to_grep(v:val)')
	endfunction
	call fzf#run(fzf#wrap('location_list', {
				\ 'source':  reverse(<sid>get_location_list()),
				\ 'sink':    function('s:open_location_item'),
				\ 'options': '--reverse',
				\ }))
endfunction

command! FZFDirectory call <SID>directories()
command! -nargs=? FZFDirectory call <SID>directories(<q-args>)
function! s:directories(...) abort
	let s:source = 'directories'
	let l:path = fnamemodify(get(a:000, 0, '.'), ':p:h')
	if !isdirectory(l:path)
		echom l:path . ' is not a directory'
	endif
	call fzf#run(
				\ fzf#wrap(s:source, {
					\	'source': reverse(split(system('find '.l:path.' -type d -print'))),
					\	'sink': 'lcd',
					\	'options': '--reverse' })
					\ )
endfunction

command! -bang FZFOutline call fzf#run(fzf#wrap('outline', s:outline(), <bang>0))
function! s:outline_format(lists) abort
	for l:list in a:lists
		let l:linenr = l:list[2][:len(l:list[2])-3]
		let l:line = getline(l:linenr)
		let l:idx = stridx(l:line, l:list[0])
		let l:len = len(l:list[0])
		let l:list[0] = l:line[:l:idx-1] . printf("\x1b[%s%sm%s\x1b[m", 34, '', l:line[l:idx : l:idx+l:len-1]) . l:line[l:idx + l:len :]
	endfor
	for l:list in a:lists
		call map(l:list, "printf('%s', v:val)")
	endfor
	return a:lists
endfunction

function! s:outline_source(tag_cmds) abort
	if !filereadable(expand('%'))
		return map(s:outline_format(map([], 'split(v:val, "\t")')), 'join(v:val, "\t")')
	endif

	let l:lines = []
	for l:cmd in a:tag_cmds
		let l:lines = split(system(l:cmd), "\n")
		if !v:shell_error
			break
		endif
	endfor
	if v:shell_error
		throw get(l:lines, 0, 'Failed to extract tags')
	elseif empty(l:lines)
		throw 'No tags found'
	endif
	return map(s:outline_format(map(l:lines, 'split(v:val, "\t")')), 'join(v:val, "\t")')
endfunction

function! s:outline_sink(lines) abort
	if !empty(a:lines)
		let l:line = a:lines[0]
		execute split(l:line, "\t")[2]
	endif
endfunction

function! s:outline(...) abort
	let s:source = 'outline'
	let l:tag_cmds = [
				\ printf('ctags -f - --sort=no --excmd=number --language-force=%s %s 2>/dev/null', &filetype, expand('%:S')),
				\ printf('ctags -f - --sort=no --excmd=number %s 2>/dev/null', expand('%:S'))]
	return {
				\ 'source':  s:outline_source(l:tag_cmds),
				\ 'sink*':   function('s:outline_sink'),
				\ 'options': '--reverse +m -d "\t" --with-nth 1 -n 1 --ansi --prompt "Outline> "'}
endfunction

command! FZFRegister call <SID>register()
function! s:yankregister(e) abort
	let @" = a:e
	echohl ModeMsg
	echo 'Yanked'
	echohl None
endfunction
function! s:register() abort
	let s:source = 'registers'
	function! s:registers_list() abort
		return split(call('execute', ['registers']), '\n')[1:]
	endfunction
	call fzf#run(fzf#wrap('registers', {
				\   'source':  reverse(<sid>registers_list()),
				\   'sink':    function('s:yankregister'),
				\   'options': '+m',
				\ }))
endfunction

" An action can be a reference to a function that processes selected lines
function! darkvim#layers#fzf#build_quickfix_list(lines)
	call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
	copen
	cc
endfunction

