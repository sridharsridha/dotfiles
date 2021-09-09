" core.vim core plugins for darkvim
scriptencoding utf-8

function! darkvim#layers#search#plugins() abort
	let l:plugins = []

	" Searching for word/cword
	" call add(l:plugins, ['mhinz/vim-grepper', {
	"			\ 'on_map' : {'nxv' : '<plug>(GrepperOperator)'},
	"			\ 'on_cmd' : ['Grepper'],
	"			\ 'loadconf' : 1,
	"			\ 'loadconf_before' : 1,
	"			\ }])

	" Interactive replace
	" call add(l:plugins, ['brooth/far.vim', {
	"			\ 'on_cmd': darkvim#util#prefix('F', ['ar', 'arp', '']),
	"			\ 'loadconf_before' : 1,
	"			\ }])

	return l:plugins
endfunction

function! darkvim#layers#search#config() abort
endfunction

