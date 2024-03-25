" g.vim --- g key bindings

" Key mapping guide for g
let g:_darkvim_mappings_g = get(g:,'_darkvim_mappings_g', {})

function! darkvim#mapping#g#init() abort
	call darkvim#mapping#g#def('nnoremap', ['&'], 'g&', 'repeat-last-":s"-on-all-lines')
	call darkvim#mapping#g#def('nnoremap', ["'"], "g'", 'jump-to-mark')
	call darkvim#mapping#g#def('nnoremap', ['`'], 'g`', 'jump-to-mark')
	call darkvim#mapping#g#def('nnoremap', ['+'], 'g+', 'newer-text-state')
	call darkvim#mapping#g#def('nnoremap', ['-'], 'g-', 'older-text-state')
	call darkvim#mapping#g#def('nnoremap', [','], 'g,', 'newer-position-in-change-list')
	call darkvim#mapping#g#def('nnoremap', [';'], 'g;', 'older-position-in-change-list')
	call darkvim#mapping#g#def('nnoremap', ['@'], 'g@', 'call-operatorfunc')
	call darkvim#mapping#g#def('nnoremap', ['$'], 'g$', 'go-to-rightmost-character')
	call darkvim#mapping#g#def('nnoremap', ['<End>'], 'g<End>', 'go-to-rightmost-character')
	call darkvim#mapping#g#def('nnoremap', ['0'], 'g0', 'go-to-leftmost-character')
	call darkvim#mapping#g#def('nnoremap', ['e'], 'ge', 'go-to-end-of-previous-word')
	call darkvim#mapping#g#def('nnoremap', ['<'], 'g<', 'last-page-of-previous-command-output')
	call darkvim#mapping#g#def('nnoremap', ['f'], 'gf', 'edit-file-under-cursor')
	call darkvim#mapping#g#def('nnoremap', ['F'], 'gF', 'edit-file-under-cursor(jump to line after name)')
	call darkvim#mapping#g#def('nnoremap', ['j'], 'gj', 'move-cursor-down-screen-line')
	call darkvim#mapping#g#def('nnoremap', ['k'], 'gk', 'move-cursor-up-screen-line')
	call darkvim#mapping#g#def('nnoremap', ['u'], 'gu', 'make-motion-text-lowercase')
	call darkvim#mapping#g#def('nnoremap', ['E'], 'gE', 'end-of-previous-word')
	call darkvim#mapping#g#def('nnoremap', ['U'], 'gU', 'make-motion-text-uppercase')
	call darkvim#mapping#g#def('nnoremap', ['H'], 'gH', 'select-line-mode')
	call darkvim#mapping#g#def('nnoremap', ['h'], 'gh', 'select-mode')
	call darkvim#mapping#g#def('nnoremap', ['I'], 'gI', 'insert-text-in-column-1')
	call darkvim#mapping#g#def('nnoremap', ['i'], 'gi', "insert-text-after-'^-mark")
	call darkvim#mapping#g#def('nnoremap', ['J'], 'gJ', 'join-lines-without-space')
	call darkvim#mapping#g#def('nnoremap', ['N'], 'gN', 'visually-select-previous-match')
	call darkvim#mapping#g#def('nnoremap', ['n'], 'gn', 'visually-select-next-match')
	call darkvim#mapping#g#def('nnoremap', ['Q'], 'gQ', 'switch-to-Ex-mode')
	call darkvim#mapping#g#def('nnoremap', ['q'], 'gq', 'format-Nmove-text')
	call darkvim#mapping#g#def('nnoremap', ['R'], 'gR', 'enter-VREPLACE-mode')
	call darkvim#mapping#g#def('nnoremap', ['T'], 'gT', 'previous-tag-page')
	call darkvim#mapping#g#def('nnoremap', ['t'], 'gt', 'next-tag-page')
	call darkvim#mapping#g#def('nnoremap', [']'], 'g', 'tselect-cursor-tag')
	call darkvim#mapping#g#def('nnoremap', ['^'], 'g^', 'go-to-leftmost-no-white character')
	call darkvim#mapping#g#def('nnoremap', ['_'], 'g_', 'go-to-last-char')
	call darkvim#mapping#g#def('nnoremap', ['~'], 'g~', 'swap-case-for-Nmove-text')
	call darkvim#mapping#g#def('nnoremap', ['a'], 'ga', 'print-ascii-value-of-cursor-character')
	call darkvim#mapping#g#def('nnoremap', ['g'], 'gg', 'go-to-line-N')
	call darkvim#mapping#g#def('nnoremap', ['m'], 'gm', 'go-to-middle-of-screenline')
	call darkvim#mapping#g#def('nnoremap', ['o'], 'go', 'goto-byte-N-in-the-buffer')
	call darkvim#mapping#g#def('nnoremap', ['s'], 'gs', 'sleep-N-seconds')
	call darkvim#mapping#g#def('nnoremap', ['v'], 'gv', 'reselect-the-previous-Visual-area')
	call darkvim#mapping#g#def('nnoremap', ['d'], 'g<C-]>', 'jump-to-tag-under-cursor')
	nnoremap <silent><expr> gp '`['.strpart(getregtype(), 0, 1).'`]'
	let g:_darkvim_mappings_g['p'] = 'select-last-paste'
	call darkvim#mapping#g#def('nnoremap', ['!'], ":<C-u>put=execute('')<Left><Left>", 'start-external-command', 2)
endfunction

function! darkvim#mapping#g#def(type, keys, value, desc, ...) abort
	let l:cmd_type = a:0 > 0 ? a:1 : 0
	let l:map_visual = a:0 > 1 ? a:2 : 0
	let l:feedkey_mode = a:type =~# 'nore' ? 'n' : 'm'
	let l:merged_keys = join(a:keys, '')
	if l:cmd_type == 1
		" a:value is a command
		let l:nmap_cmd = ':<C-u>'.a:value.'<CR>'
		let l:xmap_cmd = ':'.a:value.'<CR>'
	else
		" a:value is a key stream
		let l:nmap_cmd = a:value
		let l:xmap_cmd = a:value
	endif

	exe a:type.' g'.l:merged_keys.' '.substitute(l:nmap_cmd, '|', '\\|', 'g')
	if l:map_visual
		if a:type ==# 'nnoremap'
			exe 'xnoremap g'.l:merged_keys.' '.substitute(l:xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nmap'
			exe 'xmap g'.l:merged_keys.' ' .substitute(l:xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nnoremap <silent>'
			exe 'xnoremap <silent> g'.l:merged_keys.' '.substitute(l:xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nmap <silent>'
			exe 'xmap <silent> g'.l:merged_keys.' '.substitute(l:xmap_cmd, '|', '\\|', 'g')
		endif
	endif

	call darkvim#mapping#g#guide(a:keys, a:desc)
endfunction

function! darkvim#mapping#g#guide(keys, desc) abort
	if len(a:keys) == 3
		let g:_darkvim_mappings_g[a:keys[0]][a:keys[1]][a:keys[2]] = a:desc
	elseif len(a:keys) == 2
		let g:_darkvim_mappings_g[a:keys[0]][a:keys[1]] = a:desc
	elseif len(a:keys) == 1
		let g:_darkvim_mappings_g[a:keys[0]] = a:desc
	else
	endif
endfunction

function! darkvim#mapping#g#group(keys, desc) abort
	if len(a:keys) == 3
		if !has_key(g:_darkvim_mappings_g[a:keys[0]][a:keys[1]], a:keys[2] )
			let g:_darkvim_mappings_g[a:keys[0]][a:keys[1]][a:keys[2]] = { 'name' : '+'.a:desc }
		else
			let l:tmp_desc = g:_darkvim_mappings_g[a:keys[0]][a:keys[1]][a:keys[2]]['name']
			if l:tmp_desc !~? a:desc
				let g:_darkvim_mappings_g[a:keys[0]][a:keys[1]][a:keys[2]]['name'] = l:tmp_desc.'/'.a:desc
			endif
		endif
	elseif len(a:keys) == 2
		if !has_key(g:_darkvim_mappings_g[a:keys[0]], a:keys[1] )
			let g:_darkvim_mappings_g[a:keys[0]][a:keys[1]] = { 'name' : '+'.a:desc }
		else
			let l:tmp_desc = g:_darkvim_mappings_g[a:keys[0]][a:keys[1]]['name']
			if l:tmp_desc !~? a:desc
				let g:_darkvim_mappings_g[a:keys[0]][a:keys[1]]['name'] = l:tmp_desc.'/'.a:desc
			endif
		endif
	elseif len(a:keys) == 1
		if !has_key(g:_darkvim_mappings_g, a:keys[0] )
			let g:_darkvim_mappings_g[a:keys[0]] = { 'name' : '+'.a:desc }
		else
			let l:tmp_desc = g:_darkvim_mappings_g[a:keys[0]]['name']
			if l:tmp_desc !~? a:desc
				let g:_darkvim_mappings_g[a:keys[0]]['name'] = l:tmp_desc.'/'.a:desc
			endif
		endif
	else
	endif
endfunction

