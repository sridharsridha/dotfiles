" checker.vim linter layer darkvim
" darkvim uses neomake as default syntax checker.
"
function! darkvim#layers#checkers#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['neomake/neomake', {
				\ 'on_cmd' : ['Neomake'],
				\ 'loadconf' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#checkers#config() abort
	call darkvim#mapping#space#group(['e'], 'Errors')
	call darkvim#mapping#space#def('nnoremap', ['e', 'e'], 'call call(' . string(function('s:toggle_syntax_checker')) . ', [1])', 'toggle-syntax-checker', 1)
	call darkvim#mapping#space#def('nnoremap', ['e', 'E'], 'call call(' . string(function('s:toggle_syntax_checker')) . ', [0])', 'toggle-syntax-checker', 1)
	call darkvim#mapping#space#def('nnoremap', ['e', 'l'], 'call call(' . string(function('s:toggle_show_error')) . ', [])', 'toggle-showing-the-error-list', 1)
	call darkvim#mapping#space#def('nnoremap', ['e', 'n'], 'call call(' . string(function('s:jump_to_next_error')) . ', [])', 'next-error', 1)
	call darkvim#mapping#space#def('nnoremap', ['e', 'p'], 'call call(' . string(function('s:jump_to_previous_error')) . ', [])', 'previous-error', 1)
	call darkvim#mapping#space#def('nnoremap', ['e', 'v'], 'call call(' . string(function('s:verify_syntax_setup')) . ', [])', 'verify-syntax-setup', 1)
	call darkvim#mapping#space#def('nnoremap', ['e', 'e'], 'call call(' . string(function('s:explain_the_error')) . ', [])', 'explain-the-error', 1)
	call darkvim#mapping#space#def('nnoremap', ['e', 'c'], 'call call(' . string(function('s:clear_errors')) . ', [])', 'clear-all-errors', 1)
endfunction

function! s:toggle_show_error() abort
	try
		botright lopen
	catch
		try
			if len(getqflist()) == 0
				echohl WarningMsg
				echon 'There is no errors!'
				echohl None
			else
				botright copen
			endif
		catch
		endtry
	endtry
endfunction

function! s:jump_to_next_error() abort
	try
		lnext
	catch
		try
			cnext
		catch
			echohl WarningMsg
			echon 'There is no errors!'
			echohl None
		endtry
	endtry
endfunction

function! s:jump_to_previous_error() abort
	try
		lprevious
	catch
		try
			cprevious
		catch
			echohl WarningMsg
			echon 'There is no errors!'
			echohl None
		endtry
	endtry
endfunction

function! s:verify_syntax_setup() abort
	if exists('g:loaded_neomake')
		NeomakeInfo
	endif
endfunction

function! s:toggle_syntax_checker(enable) abort
	if a:enable == 1
		verbose Neomake
		echo 'Neomake Enabled!'
	else
		verbose NeomakeDisable
	endif
endfunction

function! s:explain_the_error() abort
	if exists('g:loaded_neomake')
		try
			let l:message = neomake#GetCurrentErrorMsg()
		catch /^Vim\%((\a\+)\)\=:E117/
			let l:message = ''
		endtry
		if !empty(l:message)
			echo l:message
		else
			echo 'no error message at this point!'
		endif
	endif
endfunction

" TODO clear errors
function! s:clear_errors() abort
	sign unplace *
endfunction

