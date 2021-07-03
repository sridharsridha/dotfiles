" space.vim --- Space key bindings

let g:_darkvim_mappings_space = get(g:,'_darkvim_mappings_space', {})

function! darkvim#mapping#space#init() abort

	call darkvim#mapping#space#group(['q'], 'Quit')
	call darkvim#mapping#space#def('nnoremap', ['q', 'q'],
				\ 'qa',
				\'prompt-kill-vim', 1)
	call darkvim#mapping#space#def('nnoremap', ['q', 'Q'],
				\ 'qa!',
				\ 'kill-vim', 1)

endfunction

function! darkvim#mapping#space#def(type, keys, value, desc, ...) abort
	let l:cmd_type = a:0 > 0 ? a:1 : 0
	let l:map_visual = a:0 > 1 ? a:2 : 0
	let l:merged_keys = join(a:keys, '')
	if l:cmd_type == 1
		" a:value is a command
		let l:nmap_cmd = ':<C-u>' . a:value . '<CR>'
		let l:xmap_cmd = ':' . a:value . '<CR>'
	else
		" a:value is a key stream
		let l:nmap_cmd = a:value
		let l:xmap_cmd = a:value
	endif
	exe a:type . ' <silent> <space>' . l:merged_keys . ' ' .
				\ substitute(l:nmap_cmd, '|', '\\|', 'g')
	if l:map_visual
		if a:type ==# 'nnoremap'
			exe 'xnoremap <silent> <space>' . l:merged_keys . ' ' .
						\ substitute(l:xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nmap'
			exe 'xmap <silent> <space>' . l:merged_keys . ' ' .
						\ substitute(l:xmap_cmd, '|', '\\|', 'g')
		endif
	endif
	call darkvim#mapping#space#guide(a:keys, a:desc)
endfunction

function! darkvim#mapping#space#guide(keys, desc) abort
	let l:keylen = len(a:keys)
	if l:keylen == 3
		let g:_darkvim_mappings_space[a:keys[0]][a:keys[1]][a:keys[2]] = a:desc
	elseif l:keylen == 2
		let g:_darkvim_mappings_space[a:keys[0]][a:keys[1]] = a:desc
	elseif l:keylen == 1
		let g:_darkvim_mappings_space[a:keys[0]] = a:desc
	else
		echoerr 'Invalid number of keys ' . a:keys
	endif
endfunction

function! darkvim#mapping#space#group(keys, desc) abort
	let l:keylen = len(a:keys)
	if l:keylen == 3
		if !has_key(g:_darkvim_mappings_space[a:keys[0]][a:keys[1]], a:keys[2] )
			let g:_darkvim_mappings_space[a:keys[0]][a:keys[1]][a:keys[2]] =
						\ { 'name' : '+'.a:desc }
		else
			let l:tmp_desc =
						\ g:_darkvim_mappings_space[a:keys[0]][a:keys[1]][a:keys[2]]['name']
			if l:tmp_desc !~? a:desc
				let g:_darkvim_mappings_space[a:keys[0]][a:keys[1]][a:keys[2]]['name'] =
							\ l:tmp_desc . '/' . a:desc
			endif
		endif
	elseif l:keylen == 2
		if !has_key(g:_darkvim_mappings_space[a:keys[0]], a:keys[1] )
			let g:_darkvim_mappings_space[a:keys[0]][a:keys[1]] =
						\ { 'name' : '+' . a:desc }
		else
			let l:tmp_desc = g:_darkvim_mappings_space[a:keys[0]][a:keys[1]]['name']
			if l:tmp_desc !~? a:desc
				let g:_darkvim_mappings_space[a:keys[0]][a:keys[1]]['name'] =
							\ l:tmp_desc . '/' . a:desc
			endif
		endif
	elseif l:keylen == 1
		if !has_key(g:_darkvim_mappings_space, a:keys[0] )
			let g:_darkvim_mappings_space[a:keys[0]] = { 'name' : '+' . a:desc }
		else
			let l:tmp_desc = g:_darkvim_mappings_space[a:keys[0]]['name']
			if l:tmp_desc !~? a:desc
				let g:_darkvim_mappings_space[a:keys[0]]['name'] = l:tmp_desc . '/' . a:desc
			endif
		endif
	else
		echoerr 'Invalid number of keys ' . a:keys
	endif
endfunction

function! darkvim#mapping#space#submode(name, mode, opt, enter_keys, map_key,
			\ cmd, desc) abort
	if dein#tap('vim-submode')
		let l:merged_keys = join(a:enter_keys, '')
		call submode#enter_with(a:name, a:mode, a:opt, '<Space>'.l:merged_keys, a:cmd)
		call submode#map(a:name, a:mode, a:opt, a:map_key, a:cmd)
		call darkvim#mapping#space#guide(a:enter_keys,
					\ a:desc . ' submode( ' . a:map_key . ' )')
	endif
endfunction

function! darkvim#mapping#space#submode2(name, mode, opt, enter_keys, cmd,
			\ desc) abort
	if dein#tap('vim-submode')
		let l:merged_keys = join(a:enter_keys, '')
		call submode#enter_with(a:name, a:mode, a:opt, '<Space>'.l:merged_keys, a:cmd)
		call darkvim#mapping#space#guide(a:enter_keys, a:desc . ' submode')
		"call submode#leave_with(a:name, a:mode, a:opt, '<Esc>')
	endif
endfunction

function! darkvim#mapping#space#submode_map(submode, modes, options, lhs, rhs) abort
	if dein#tap('vim-submode')
		call submode#map(a:submode, a:modes, a:options, a:lhs, a:rhs)
	endif
endfunction

