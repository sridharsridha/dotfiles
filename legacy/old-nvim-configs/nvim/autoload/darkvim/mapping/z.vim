" z.vim --- z key bindings

" Key mapping guide for z
let g:_darkvim_mappings_z = get(g:,'_darkvim_mappings_z', {})

function! darkvim#mapping#z#init() abort
	" Z mappings
	call darkvim#mapping#z#def('nnoremap', ['<CR>'], 'z<CR>', 'cursor-line-to-top')
	call darkvim#mapping#z#def('nnoremap', ['+'], 'z+', 'cursor-to-screen-top-line-N')
	call darkvim#mapping#z#def('nnoremap', ['-'], 'z-', 'cursor-to-screen-bottom-line-N')
	call darkvim#mapping#z#def('nnoremap', ['^'], 'z^', 'cursor-to-screen-bottom-line-N')
	call darkvim#mapping#z#def('nnoremap', ['.'], 'z.', 'cursor-line-to-center')
	call darkvim#mapping#z#def('nnoremap', ['='], 'z=', 'spelling-suggestions')
	call darkvim#mapping#z#def('nnoremap', ['A'], 'zA', 'toggle-folds-recursively')
	call darkvim#mapping#z#def('nnoremap', ['C'], 'zC', 'close-folds-recursively')
	call darkvim#mapping#z#def('nnoremap', ['D'], 'zD', 'delete-folds-recursively')
	call darkvim#mapping#z#def('nnoremap', ['E'], 'zE', 'eliminate-all-folds')
	call darkvim#mapping#z#def('nnoremap', ['F'], 'zF', 'create-a-fold-for-N-lines')
	call darkvim#mapping#z#def('nnoremap', ['G'], 'zG', 'mark-good-spelled (update internal wordlist)')
	call darkvim#mapping#z#def('nnoremap', ['H'], 'zH', 'scroll-half-screenwidth-to-right')
	call darkvim#mapping#z#def('nnoremap', ['L'], 'zL', 'scroll-half-screenwidth-to-left')
	call darkvim#mapping#z#def('nnoremap', ['M'], 'zM', 'set-`foldlevel`-to-zero')
	call darkvim#mapping#z#def('nnoremap', ['N'], 'zN', 'set-`foldenable`')
	call darkvim#mapping#z#def('nnoremap', ['O'], 'zO', 'open-folds-recursively')
	call darkvim#mapping#z#def('nnoremap', ['R'], 'zR', 'set-`foldlevel`-to-deepest-fold')
	call darkvim#mapping#z#def('nnoremap', ['W'], 'zW', 'mark-wrong-spelled (update internal wordlist)')
	call darkvim#mapping#z#def('nnoremap', ['X'], 'zX', 're-apply-`foldleve`')
	call darkvim#mapping#z#def('nnoremap', ['a'], 'za', 'toggle-fold')
	call darkvim#mapping#z#def('nnoremap', ['b'], 'zb', 'redraw (cursor line at bottom)')
	call darkvim#mapping#z#def('nnoremap', ['c'], 'zc', 'close-fold')
	call darkvim#mapping#z#def('nnoremap', ['d'], 'zd', 'delete-fold')
	call darkvim#mapping#z#def('nnoremap', ['e'], 'ze', 'right-scroll-horizontally-to-cursor-position')
	call darkvim#mapping#z#def('nnoremap', ['f'], 'zf', 'create-fold-for-motion')
	call darkvim#mapping#z#def('nnoremap', ['g'], 'zg', 'mark-good-spelled')
	call darkvim#mapping#z#def('nnoremap', ['h'], 'zh', 'scroll-screen-N-characters-to-right')
	call darkvim#mapping#z#def('nnoremap', ['<Left>'], 'z<Left>', 'scroll-screen-N-characters-to-left')
	call darkvim#mapping#z#def('nnoremap', ['i'], 'zi', 'toggle-foldenable')
	call darkvim#mapping#z#def('nnoremap', ['j'], 'zj', 'move-to-start-of-next-fold')
	call darkvim#mapping#z#def('nnoremap', ['J'], 'zJ', 'move-to-and open next fold')
	call darkvim#mapping#z#def('nnoremap', ['k'], 'zk', 'move-to-end-of-previous-fold')
	call darkvim#mapping#z#def('nnoremap', ['K'], 'zK', 'move-to-and-open-previous-fold')
	call darkvim#mapping#z#def('nnoremap', ['l'], 'zl', 'scroll-screen-N-characters-to-left')
	call darkvim#mapping#z#def('nnoremap', ['<Right>'], 'z<Right>', 'scroll-screen-N-characters-to-right')
	call darkvim#mapping#z#def('nnoremap', ['m'], 'zm', 'subtract-one-from-`foldlevel`')
	call darkvim#mapping#z#def('nnoremap', ['n'], 'zn', 'reset-`foldenable`')
	call darkvim#mapping#z#def('nnoremap', ['o'], 'zo', 'open-fold')
	call darkvim#mapping#z#def('nnoremap', ['r'], 'zr', 'add-one-to-`foldlevel`')
	call darkvim#mapping#z#def('nnoremap', ['s'], 'zs', 'left-scroll-horizontally-to-cursor-position')
	call darkvim#mapping#z#def('nnoremap', ['t'], 'zt', 'cursor-line-at-top-of-window')
	call darkvim#mapping#z#def('nnoremap', ['v'], 'zv', 'open-enough-folds-to-view-cursor-line')
	call darkvim#mapping#z#def('nnoremap', ['w'], 'zw', 'mark-wrong-spelled')
	call darkvim#mapping#z#def('nnoremap', ['x'], 'zx', 're-apply-foldlevel-and-do-"zV"')
	call darkvim#mapping#z#def('nnoremap', ['z'], 'zz', 'smart-scroll')
endfunction

function! darkvim#mapping#z#def(type, keys, value, desc, ...) abort
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

	exe a:type.' z'.l:merged_keys.' '.substitute(l:nmap_cmd, '|', '\\|', 'g')
	if l:map_visual
		if a:type ==# 'nnoremap'
			exe 'xnoremap z'.l:merged_keys.' '.substitute(l:xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nmap'
			exe 'xmap z'.l:merged_keys.' ' .substitute(l:xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nnoremap <silent>'
			exe 'xnoremap <silent> z'.l:merged_keys.' '.substitute(l:xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nmap <silent>'
			exe 'xmap <silent> z'.l:merged_keys.' '.substitute(l:xmap_cmd, '|', '\\|', 'g')
		endif
	endif

	call darkvim#mapping#z#guide(a:keys, a:desc)
endfunction

function! darkvim#mapping#z#guide(keys, desc) abort
	if len(a:keys) == 3
		let g:_darkvim_mappings_z[a:keys[0]][a:keys[1]][a:keys[2]] = a:desc
	elseif len(a:keys) == 2
		let g:_darkvim_mappings_z[a:keys[0]][a:keys[1]] = a:desc
	elseif len(a:keys) == 1
		let g:_darkvim_mappings_z[a:keys[0]] = a:desc
	else
	endif
endfunction

