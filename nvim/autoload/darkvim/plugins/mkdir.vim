" mkdir.vim --- auto mkdir when saving file

let s:save_cpoptions = &cpoptions
set cpoptions&vim

function! darkvim#plugins#mkdir#create_current() abort
	call s:create_directory(expand('%:p:h'))
endfunction

fun! s:mkdirp(dir) abort
	if exists('*mkdir')
		try
			call mkdir(a:dir, 'p')
		catch
		endtry
	else
		" @todo mkdir only exist in *nix os
		call system('mkdir -p '.shellescape(a:dir))
	end
endf

fun! s:create_directory(dir) abort
	let l:d = a:dir

	" @todo do not skip files that have schemes
	if l:d =~? '^[a-z]\+:/'
		return
	endif

	if !isdirectory(l:d)
		call s:mkdirp(l:d)
	end
endf

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
