"=============================================================================
" custom.vim --- Load the custom darkvim configuration folder to runtime
" Author: Sridhar Nagarajan ( sridha.in@gmail.com )
" Date: 2019:11:28
" License: None
"=============================================================================

let s:FILE = darkvim#api#import('file')
let s:CMP = darkvim#api#import('vim#compatible')

function! darkvim#custom#load() abort
	if filereadable('.darkvim.d/init.vim')
		let g:_darkvim_config_path = fnamemodify('.darkvim.d/init.vim', ':p')
		let &runtimepath =  s:FILE.unify_path(s:CMP.resolve(fnamemodify('.darkvim.d', ':p:h'))) . ',' . &runtimepath
		let l:local_conf = g:_darkvim_config_path
		exe 'source .darkvim.d/init.vim'
	else
		call s:load_glob_conf()
	endif
endfunction

function! s:load_glob_conf() abort
	let l:global_dir = empty($DARKVIMDIR) ? s:FILE.unify_path(s:CMP.resolve(expand('~/.darkvim.d/'))) : $DARKVIMDIR
	if filereadable(l:global_dir . 'init.vim')
		let g:_darkvim_global_config_path = l:global_dir . 'init.vim'
		let l:custom_glob_conf = l:global_dir . 'init.vim'
		let &runtimepath = l:global_dir . ',' . &runtimepath
		exe 'source ' . l:custom_glob_conf
	endif
endfunction
