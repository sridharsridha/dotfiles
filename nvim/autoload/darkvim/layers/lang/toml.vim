" toml.vim --- toml layer for darkvim

function! darkvim#layers#lang#toml#plugins() abort
	let l:plugins = []
	call add(l:plugins, ['cespare/vim-toml', {
				\ 'on_ft' : ['toml'],
				\ }])
	return l:plugins
endfunction

function! darkvim#layers#lang#toml#config() abort

endfunction
