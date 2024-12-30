
function! darkvim#layers#lang#qf#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['yssl/QFEnter', {
				\ 'on_ft' : ['qf'],
				\ 'loadconf_before' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#lang#qf#config() abort
endfunction

function! s:language_specified_mappings() abort
endfunction

