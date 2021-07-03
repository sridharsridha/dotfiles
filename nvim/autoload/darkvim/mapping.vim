" mapping.vim --- mapping functions in darkvim
"
scriptencoding utf-8

function! darkvim#mapping#def(type, key, value, desc, ...) abort
	let l:map_visual = a:0 > 1 ? a:1 : 0
	let l:cmd = substitute(a:value, '|', '\\|', 'g')
	exe a:type.' '.a:key.' '.l:cmd
	if l:map_visual
		if a:type ==# 'nnoremap'
			exe 'xnoremap '.a:key.' '.l:cmd
		elseif a:type ==# 'nmap'
			exe 'xmap '.a:key.' ' .l:cmd
		endif
	endif
endfunction

