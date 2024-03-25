" tags.vim --- darkvim gtags layer
function! darkvim#layers#tags#plugins() abort
	let l:plugins = []

	" Automatic tag generation
	call add(l:plugins, ['ludovicchabant/vim-gutentags', {
				\ 'on_event' : [ 'BufEnter' ],
				\ 'loadconf' : 1,
				\ 'loadconf_before' : 1,
				\ }])

	" Open symbols window
	call add(l:plugins, ['majutsushi/tagbar', {
				\ 'on_cmd' : ['TagbarToggle'],
				\ 'loadconf' : 1,
				\ 'loadconf_before' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#tags#config() abort
	call darkvim#mapping#space#group(['t'], 'Tags')
	call darkvim#mapping#space#def('nnoremap', ['t', 'c'],
				\ 'call darkvim#plugins#cscope#find("c", expand("<cword>"))',
				\ 'find-functions-calling-this-function', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'd'],
				\ 'call darkvim#plugins#cscope#find("g", expand("<cword>"))',
				\ 'find-global-definition-of-a-symbol', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 's'],
				\ 'call darkvim#plugins#cscope#find("s", expand("<cword>"))',
				\ 'find-references-of-a-symbol', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'f'],
				\ 'call darkvim#plugins#cscope#find("f", expand("<cword>"))',
				\ 'find-files', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'i'],
				\ 'call darkvim#plugins#cscope#find("i", expand("<cword>"))',
				\ 'find-files-including-this-file', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'e'],
				\ 'call darkvim#plugins#cscope#find("e", expand("<cword>"))',
				\ 'Find-this-egrep-pattern', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 't'],
				\ 'call darkvim#plugins#cscope#find("t", expand("<cword>"))',
				\ 'find-this-text-string', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'a'],
				\ 'call darkvim#plugins#cscope#find("a", expand("<cword>"))',
				\ 'find-assignments-to-this-symbol', 1)
endfunction


