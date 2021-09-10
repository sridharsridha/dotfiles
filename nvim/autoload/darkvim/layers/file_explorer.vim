function! darkvim#layers#file_explorer#plugins() abort
	let l:plugins = []
	if has('python3')
		" FileTree Explorer
		call add(l:plugins, ['kristijanhusak/defx-icons'])
		call add(l:plugins, ['Shougo/defx.nvim', {
					\ 'depends' : ['defx-icons'],
					\ 'on_cmd' : ['Defx'],
					\ 'loadconf' : 1,
					\ 'loadconf_before' : 1,
					\ }])

		" Show git file markers in defx
		call add(l:plugins, ['kristijanhusak/defx-git', {
					\ 'on_source' : ['defx.nvim'],
					\ 'loadconf' : 1,
					\ }])
	endif

	return l:plugins
endfunction

function! darkvim#layers#file_explorer#config() abort

endfunction



