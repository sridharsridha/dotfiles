function! darkvim#layers#lang#vim#plugins() abort
	let l:plugins = []
	call add(l:plugins , ['tweekmonster/exception.vim', {
				\ 'on_ft': 'vim',
				\ }])
	call add(l:plugins , ['tweekmonster/helpful.vim', {
				\ 'on_cmd': 'HelpfulVersion',
				\ }])
	return l:plugins
endfunction

function! darkvim#layers#lang#vim#config() abort
	call darkvim#mapping#localleader#reg_lang_mappings_cb('vim', function('s:language_specified_mappings'))
endfunction

function! s:language_specified_mappings() abort
	call darkvim#mapping#localleader#def('nmap', ['v'],  'call call('
				\ . string(function('s:helpversion_cursor')) . ', [])',
				\ 'echo helpversion under cursor', 1)
	call darkvim#mapping#localleader#def('nmap', ['f'], 'call exception#trace()', 'tracing exceptions', 1)
endfunction

function! s:helpversion_cursor() abort
	exe 'HelpfulVersion' expand('<cword>')
endfunction
