" python.vim --- darkvim lang#python layer

function! darkvim#layers#lang#python#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['jeetsukumaran/vim-pythonsense', {
				\ 'on_ft' : 'python',
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#lang#python#config() abort
	augroup python_delimit
		au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
	augroup end
	call darkvim#mapping#localleader#reg_lang_mappings_cb('python',
				\ function('s:language_specified_mappings'))
endfunction

function! s:language_specified_mappings() abort
	if darkvim#layers#is_loaded('format')
		call darkvim#mapping#localleader#group(['i'], 'Imports')
		call darkvim#mapping#localleader#def('nmap', ['i', 's'],
					\ 'Neoformat isort',
					\ 'sort imports', 1)
		call darkvim#mapping#localleader#def('nmap', ['i', 'r'],
					\ 'Neoformat autoflake',
					\ 'remove unused imports', 1)
	endif
endfunction
