" File              : layers.vim
" License           : None
" Author            : Sridhar Nagarajan <sridha.in@gmail.com>
" Date              : 14.03.2020
" Last Modified Date: 14.03.2020
" Last Modified By  : Sridhar Nagarajan <sridha.in@gmail.com>
scriptencoding utf-8

let g:enabled_layers = []

"" Public

" Load the [layers] you want.
function! darkvim#layers#load(layers) abort
	if type(a:layers) == type('')
		" string
		call s:add_layer(a:layers)
	else
	endif
endfunction

" Disable layers
function! darkvim#layers#disable(layer) abort
	let l:index = index(g:enabled_layers, a:layer)
	if l:index != -1
		call remove(g:enabled_layers, l:index)
	endif
endfunction

" Get loaded layers
function! darkvim#layers#get() abort
	return deepcopy(g:enabled_layers)
endfunction

" Check if a layer is loaded
function! darkvim#layers#is_loaded(layer) abort
	return index(g:enabled_layers, a:layer) != -1
endfunction

"" Internal
"
function! s:add_layer(layer) abort
	if index(g:enabled_layers, a:layer) == -1
		call add(g:enabled_layers, a:layer)
	endif
endfunction

