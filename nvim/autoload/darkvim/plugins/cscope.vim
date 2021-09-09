" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag
" check cscope for definition of a symbol before checking ctags: set to 1
" if you want the reverse search order.
set cscopetagorder=0

" Use quickfix window for cscope results. Clear previous results before the search.
set cscopequickfix=s+,c+,d+,i+,t+,e+,g+,f+

" Title String
function! s:set_title(what, query) abort
	let l:text = ''
	if a:what ==# '0' || a:what ==# 's'
		let l:text = 'symbol '.a:query
	elseif a:what ==# '1' || a:what ==# 'g'
		let l:text = 'definition of '.a:query
	elseif a:what ==# '2' || a:what ==# 'd'
		let l:text = 'functions called by '.a:query
	elseif a:what ==# '3' || a:what ==# 'c'
		let l:text = 'functions calling '.a:query
	elseif a:what ==# '4' || a:what ==# 't'
		let l:text = 'string '.a:query
	elseif a:what ==# '6' || a:what ==# 'e'
		let l:text = 'egrep '.a:query
	elseif a:what ==# '7' || a:what ==# 'f'
		let l:text = 'file '.a:query
	elseif a:what ==# '8' || a:what ==# 'i'
		let l:text = 'files including '.a:query
	elseif a:what ==# '9' || a:what ==# 'a'
		let l:text = 'assigned '.a:query
	endif
	exec 'cexpr text'
	let l:title = l:text
	call setqflist([], 'a', {'title':l:title})
endfunc

" Run cscope
function! s:run(search_query) abort
	let l:MESSAGE = darkvim#api#import('vim#message')
	let l:success = 1
	try
		silent! keepjumps execute a:search_query
		redrawstatus
	catch /^Vim\%((\a\+)\)\=:E567/
		redrawstatus
		call l:MESSAGE.error('E567: no cscope connections')
		let l:success = 0
	catch /^Vim\%((\a\+)\)\=:E/
		redrawstatus
		call l:MESSAGE.error('ERROR: cscope error')
		let l:success = 0
	endtry
	return l:success
endfunc

function! darkvim#plugins#cscope#open_list() abort
   if exists( ":Denite"  )
      Denite quickfix
   elseif exists( ":FZFQuickfix" )
      FZFQuickfix
   else
      botright copen
   endif
endfunction

" Find search
function! darkvim#plugins#cscope#find(what, query) abort
	if empty(a:query)
		let l:query = input(g:darkvim_commandline_prompt . ' ')
		normal! :
	else
		let l:query = a:query
	endif
	let l:query = fnameescape(l:query)
	cclose
	call setqflist([])
	call s:set_title(a:what, l:query)
	let l:cmd = 'cs find ' . a:what . ' ' . l:query
	call s:run(l:cmd)
	call darkvim#plugins#cscope#open_list()
endfunc

