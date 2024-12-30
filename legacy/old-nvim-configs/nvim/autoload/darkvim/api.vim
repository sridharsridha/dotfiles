" api.vim --- darkvim api

let s:apis = {}
" the api itself is a dict, and it will be changed when user use the api. so
" every time when request a api, we should provide an clean api.
function! darkvim#api#import(name) abort
	if has_key(s:apis, a:name)
		return deepcopy(s:apis[a:name])
	endif
	let l:p = {}
	try
		let l:p = darkvim#api#{a:name}#get()
		let s:apis[a:name] = deepcopy(l:p)
	catch /^Vim\%((\a\+)\)\=:E117/
	endtry
	return l:p
endfunction

function! darkvim#api#register(name, api) abort
	if !empty(darkvim#api#import(a:name))
		echoerr '[darkvim api] api : ' . a:name . ' already existed!'
	else
		let s:apis[a:name] = deepcopy(a:api)
	endif
endfunction

