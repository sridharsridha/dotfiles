"=============================================================================
" message.vim --- darkvim message API
"=============================================================================

""
" @section vim#message, api-vim-message
" @parentsection api


let s:self = {}

function! s:self.echo(hl, msg) abort
	execute 'echohl' a:hl
	try
		echo a:msg
	finally
		echohl None
	endtry
endfunction

function! s:self.echomsg(hl, msg) abort
	execute 'echohl' a:hl
	try
		for l:m in split(a:msg, "\n")
			echomsg l:m
		endfor
	finally
		echohl None
	endtry
endfunction

function! s:self.error(msg) abort
	call s:self.echomsg('ErrorMsg', a:msg)
endfunction

function! s:self.warn(msg) abort
	call s:self.echomsg('WarningMsg', a:msg)
endfunction

function! s:self.confirm(msg) abort
	echohl WarningMsg
	echon a:msg . '? (y or n) '
	echohl NONE
	let l:rst = nr2char(getchar())
	" clear the cmdline
	redraw!
	if l:rst =~? 'y' || l:rst == nr2char(13)
		return 1
	else
		return 0
	endif
endfunction


function! darkvim#api#vim#message#get() abort
	return deepcopy(s:self)
endfunction
