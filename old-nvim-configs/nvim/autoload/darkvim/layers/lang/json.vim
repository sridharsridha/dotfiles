function! darkvim#layers#lang#json#plugins() abort
	let l:plugins = []
	call add(l:plugins, ['elzr/vim-json', {
				\ 'on_ft' : ['javascript','json'],
				\ }])
	return l:plugins
endfunction

function! darkvim#layers#lang#json#config() abort
	let g:vim_json_syntax_conceal = 0
	let g:vim_json_syntax_concealcursor = ''
endfunction
