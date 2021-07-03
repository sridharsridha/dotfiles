" Improved editing layers for darkvim
"
scriptencoding utf-8

function! darkvim#layers#edit#plugins() abort
	let l:plugins = []

	" Adds bunch of testobjs (quotes, brackets, etc with a, i, A, I, n, l)
	call add(l:plugins, ['wellle/targets.vim', {
				\ 'loadconf_before' : 1,
				\ 'nolazy' : 1,
				\ }])

	" textobject 'i/I' for indentation
	call add(l:plugins, ['kana/vim-textobj-indent', {
				\ 'depends':[ 'vim-textobj-user' ],
				\ 'on_map':{'vo':'<Plug>(textobj-indent-'},
				\ 'loadconf_before' : 1,
				\ }])

	" textobj 'L' for selecting line
	call add(l:plugins, ['kana/vim-textobj-line', {
				\ 'depends':[ 'vim-textobj-user' ],
				\ 'on_map':{'vo':'<Plug>(textobj-line-'},
				\ 'loadconf_before' : 1,
				\ }])

	" textobj 'e' for selection entire text
	" Usefull for bulk copying result operator or clipboard
	call add(l:plugins, ['kana/vim-textobj-entire', {
				\ 'depends':[ 'vim-textobj-user' ],
				\ 'on_map':{'vo':'<Plug>(textobj-entire-'},
				\ 'loadconf_before' : 1,
				\ }])

	" textobj 'c/C' for seletin comments
	call add(l:plugins, ['glts/vim-textobj-comment', {
				\ 'depends':[ 'vim-textobj-user' ],
				\ 'on_map':{'vo':'<Plug>(textobj-comment-'},
				\ 'loadconf_before' : 1,
				\ }])

	" textobj 'f/F' for selecting functions
	call add(l:plugins, ['kana/vim-textobj-function', {
				\ 'depends' : [ 'vim-textobj-user' ],
				\ 'on_map' : {'vo':'<Plug>(textobj-function-'},
				\ 'loadconf_before' : 1,
				\ }])

	" add/change/del quotes etc around word
	call add(l:plugins, ['tpope/vim-surround', {
				\ 'depends': 'vim-repeat',
				\ 'on_map': {
				\   'i': ['<C-g>S', '<C-g>s', '<C-s>'],
				\   'n': ['cS', 'cs', 'ds', 'yS', 'ys'],
				\   'x': 'S',
				\ },
				\ }])

	" Improved J
	call add(l:plugins, ['osyo-manga/vim-jplus', {
				\ 'on_map' : {'n' : '<Plug>(jplus'},
				\ 'loadconf_before' : 1,
				\ }])

	" Bullets/List/Checkbox support
	call add(l:plugins, ['dkarter/bullets.vim', {
				\ 'on_ft': ['gitcommit', 'text', 'markdown', 'md', 'config'],
				\ 'loadconf_before' : 1,
				\ }])

	" Table Mode for writing tables triggered using '||'
	call add(l:plugins, ['dhruvasagar/vim-table-mode', {
				\ 'on_cmd': darkvim#util#prefix('TableMode', ['Toggle', 'Enable', 'Disable']),
				\ 'loadconf_before' : 1,
				\ }])

	" Align text motion support gl, gL motion
	" call add(l:plugins, ['tommcdo/vim-lion', {
	"			\ 'on_map': {'n': ['gl', 'gL']},
	"			\ }])

	" Convert text into table using delimiters helful for formatting code
	call add(l:plugins, ['godlygeek/tabular', {
				\ 'on_cmd' : ['Tabularize'],
				\ 'loadconf_before' : 1,
				\ }])

	" Faster j and k movement
	call add(l:plugins, ['rhysd/accelerated-jk', {
				\ 'on_map' : {'n' : '<Plug>(accelerated_'},
				\ 'loadconf_before' : 1,
				\ }])

	" Split and join code
	call add(l:plugins, ['AndrewRadev/splitjoin.vim', {
				\ 'on_cmd': darkvim#util#prefix('Splitjoin', ['Join', 'Split']),
				\ 'on_map': {'n': ['gJ', 'gS']},
				\ 'loadconf_before' : 1,
				\ }])

	" Exchange text between two regions
	call add(l:plugins, ['tommcdo/vim-exchange', {
				\ 'on_map': {
				\   'n': 'cx',
				\   'v': 'X',
				\ },
				\ }])

	" Move an item in a delimiter-separated list left or right
	call add(l:plugins, ['AndrewRadev/sideways.vim', {
				\ 'on_cmd': darkvim#util#prefix('Sideways', ['Left', 'Right']),
				\ 'loadconf_before' : 1,
				\ }])

	" Covert a number between different base representations
	call add(l:plugins, ['glts/vim-magnum'])
	call add(l:plugins, ['glts/vim-radical', {
				\ 'depends' : ['vim-magnum', 'vim-repeat'],
				\ 'on_map' : {'nvx' : ['gA', 'crd', 'crx', 'cro', 'crb']}
				\ }])

	" Multiple cursor support
	call add(l:plugins, ['terryma/vim-multiple-cursors', {
				\ 'on_event' : ['BufReadPost'],
				\ 'loadconf_before' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#edit#config() abort

	" Uppercase/Lowercase
	call darkvim#mapping#space#group(['x'], 'Text')
	call darkvim#mapping#space#def('vnoremap', ['x', 'u'], 'gu', 'set the selected text to lower case', 0)
	call darkvim#mapping#space#def('vnoremap', ['x', 'U'], 'gU', 'set the selected text to up case', 0)

	call darkvim#mapping#space#group(['x'], 'Text')
	call darkvim#mapping#space#group(['x', 'w'], 'Word')
	call darkvim#mapping#space#def('vnoremap', ['x', 'w', 'c'], 'normal! ' . ":'<,'>s/\\\w\\+//gn" . "\<cr>", 'count the words in the select region', 1)

	call darkvim#mapping#space#group(['x', 'j'], 'Justification')
	call darkvim#mapping#space#def('nnoremap', ['x', 'j', 'l'], 'silent call call('
				\ . string(function('s:set_justification_to')) . ', ["left"])',
				\ 'set-the-justification-to-left', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'j', 'c'], 'silent call call('
				\ . string(function('s:set_justification_to')) . ', ["center"])',
				\ 'set-the-justification-to-center', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'j', 'r'], 'silent call call('
				\ . string(function('s:set_justification_to')) . ', ["right"])',
				\ 'set-the-justification-to-right', 1)

	" String concatination and spliting mapping
	call darkvim#mapping#space#group(['x', 's'], 'String')
	call darkvim#mapping#space#def('nnoremap', ['x', 's', 'j'],
				\ 'call call(' . string(function('s:string_join_with')) . ',[])',
				\ 'join-string-with', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 's', 's'],
				\ 'call call(' . string(function('s:string_split')) . ',[0])',
				\ 'split-sexp', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 's', 'n'],
				\ 'call call(' . string(function('s:string_split')) . ',[])',
				\ 'split-and-add-newline', 1)

	" Move lines using submode
	call darkvim#mapping#space#group(['x', 'm'], 'Move')
	call darkvim#mapping#space#submode2('TextMoveJ', 'n', '', ['x', 'm', 'j'],
				\ ':normal! ddp<cr>',
				\ 'move-text-down j')
	call darkvim#mapping#space#submode_map('TextMoveJ', 'n', '', 'j',
				\ ':noautocmd silent! m .+1<cr>')
	call darkvim#mapping#space#submode_map('TextMoveJ', 'n', '', 'k',
				\ ':noautocmd silent! m .-2<cr>')

	call darkvim#mapping#space#submode2('TextMoveK', 'n', '', ['x', 'm', 'k'],
				\ ':normal! ddkP<cr>',
				\ 'move-text-up k' )
	call darkvim#mapping#space#submode_map('TextMoveK', 'n', '', 'j',
				\ ':noautocmd silent! m .+1<cr>')
	call darkvim#mapping#space#submode_map('TextMoveK', 'n', '', 'k',
				\ ':noautocmd silent! m .-2<cr>')

	" Duplicate lines
	call darkvim#mapping#space#group(['x', 'c'], 'copy')
	call darkvim#mapping#space#submode2('TextDupJ', 'n', '', ['x', 'c', 'j'],
				\ 'mzyyP`z',
				\ 'duplicate-line-down j')
	call darkvim#mapping#space#submode_map('TextDupJ', 'n', '', 'j',
				\ 'mzyyP`z')
	call darkvim#mapping#space#submode_map('TextDupJ', 'n', '', 'k',
				\ 'mzyyP`zk')
	call darkvim#mapping#space#submode2('TextDupK', 'n', '', ['x', 'c', 'k'],
				\ 'mzyyP`zk',
				\ 'duplicate-line-up k')
	call darkvim#mapping#space#submode_map('TextDupK', 'n', '', 'j',
				\ 'mzyyP`z')
	call darkvim#mapping#space#submode_map('TextDupK', 'n', '', 'k',
				\ 'mzyyP`zk')

	call darkvim#mapping#space#group(['x', 't'], 'Transpose')
	call darkvim#mapping#space#def('nnoremap', ['x', 't', 'c'], 'call call('
				\ . string(function('s:transpose_with_previous')) . ', ["character"])',
				\ 'swap-current-character-with-previous-one', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 't', 'w'], 'call call('
				\ . string(function('s:transpose_with_previous')) . ', ["word"])',
				\ 'swap-current-word-with-previous-one', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 't', 'l'], 'call call('
				\ . string(function('s:transpose_with_previous')) . ', ["line"])',
				\ 'swap-current-line-with-previous-one', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 't', 'C'], 'call call('
				\ . string(function('s:transpose_with_next')) . ', ["character"])',
				\ 'swap-current-character-with-next-one', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 't', 'W'], 'call call('
				\ . string(function('s:transpose_with_next')) . ', ["word"])',
				\ 'swap-current-word-with-next-one', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 't', 'L'], 'call call('
				\ . string(function('s:transpose_with_next')) . ', ["line"])',
				\ 'swap-current-line-with-next-one', 1)

endfunction

function! s:transpose_with_previous(type) abort
	let l:save_register = @"
	if a:type ==# 'line'
		if line('.') > 1
			normal! kddp
		endif
	elseif a:type ==# 'word'
		normal! yiw
		let l:cw = @"
		normal! geyiw
		let l:tw = @"
		if l:cw !=# l:tw
			let @" = l:cw
			normal! viwp
			let @" = l:tw
			normal! eviwp
		endif
	elseif a:type ==# 'character'
		if col('.') > 1
			normal! hxp
		endif
	endif
	let @" = l:save_register
endfunction

function! s:transpose_with_next(type) abort
	let l:save_register = @"
	if a:type ==# 'line'
		if line('.') < line('$')
			normal! ddp
		endif
	elseif a:type ==# 'word'
		normal! yiw
		let l:cw = @"
		normal! wyiw
		let l:nw = @"
		if l:cw !=# l:nw
			let @" = l:cw
			normal! viwp
			let @" = l:nw
			normal! geviwp
		endif
	elseif a:type ==# 'character'
		if col('.') < col('$')-1
			normal! xp
		endif
	endif
	let @" = l:save_register
endfunction

" String Joinning functions
let s:string_info = {
			\ 'vim' : {
			\ 'connect' : '.',
			\ 'line_prefix' : '\',
			\ },
			\ 'java' : {
			\ 'connect' : '+',
			\ 'line_prefix' : '',
			\ },
			\ 'cpp' : {
			\ 'connect' : '+',
			\ 'line_prefix' : '',
			\ },
			\ 'perl' : {
			\ 'connect' : '.',
			\ 'line_prefix' : '\',
			\ },
			\ 'python' : {
			\ 'connect' : '+',
			\ 'line_prefix' : '\',
			\ 'quotes_hi' : ['pythonQuotes']
			\ },
			\ }

function! s:string_join_with() abort
	if s:is_string(line('.'), col('.'))
		let l:c = col('.')
		let l:a = 0
		let l:b = 0
		let l:_c = l:c
		while l:c > 0
			if s:is_string(line('.'), l:c)
				let l:c -= 1
			else
				let l:a = l:c
				break
			endif
		endwhile
		let l:c = l:_c
		while l:c > 0
			if s:is_string(line('.'), l:c)
				let l:c += 1
			else
				let l:b = l:c
				break
			endif
		endwhile
		let l:save_register_m = @m
		let l:line = getline('.')[:l:a] . join(split(getline('.')[l:a+1 : l:b]), '-') .
					\ getline('.')[l:b :]
		call setline('.', l:line)
		let @m = l:save_register_m
	endif
endfunction

function! s:string_split(newline) abort
	if s:is_string(line('.'), col('.'))
		let l:save_cursor = getcurpos()
		let l:c = col('.')
		let l:sep = ''
		while l:c > 0
			if s:is_string(line('.'), l:c)
				let l:c -= 1
			else
				if !empty(get(get(s:string_info, &filetype, {}), 'quotes_hi', []))
					let l:sep = getline('.')[l:c - 1]
				else
					let l:sep = getline('.')[l:c]
				endif
				break
			endif
		endwhile
		let l:addedtext = a:newline ? "\n" .
					\ get(get(s:string_info, &filetype, {}), 'line_prefix', '') : ''
		let l:connect = get(get(s:string_info, &filetype, {}), 'connect', '')
		if !empty(l:connect)
			let l:connect = ' ' . l:connect . ' '
		endif
		if a:newline
			let l:addedtext = l:addedtext . l:connect
		else
			let l:addedtext = l:connect
		endif
		let l:save_register_m = @m
		let @m = l:sep . l:addedtext . l:sep
		normal! "mp
		let @m = l:save_register_m
		if a:newline
			normal! j==
		endif
		call setpos('.', l:save_cursor)
	endif
endfunction

" @toto add sting highlight for other filetype
let s:string_hi = {
			\ 'c' : 'cCppString',
			\ 'cpp' : 'cCppString',
			\ 'python' : 'pythonString',
			\ }

function! s:is_string(l, c) abort
	return synIDattr(synID(a:l, a:c, 1), 'name') ==
				\ get(s:string_hi, &filetype, &filetype . 'String')
endfunction

function! s:set_justification_to(align) abort
	let l:startlinenr = line("'{")
	let l:endlinenr = line("'}")
	if getline(l:startlinenr) ==# ''
		let l:startlinenr += 1
	endif
	if getline(l:endlinenr) ==# ''
		let l:endlinenr -= 1
	endif
	let l:lineList = map(getline(l:startlinenr, l:endlinenr), 'trim(v:val)')
	let l:maxlength = 0
	for l:line in l:lineList
		let l:length = strdisplaywidth(l:line)
		if l:length > l:maxlength
			let l:maxlength = l:length
		endif
	endfor

	if a:align ==# 'left'
		execute l:startlinenr . ',' . l:endlinenr . ":left\<cr>"
	elseif a:align ==# 'center'
		execute l:startlinenr . ',' . l:endlinenr . ':center ' . l:maxlength . "\<cr>"
	elseif a:align ==# 'right'
		execute l:startlinenr . ',' . l:endlinenr . ':right  ' . l:maxlength . "\<cr>"
	endif

	unlet l:startlinenr
	unlet l:endlinenr
	unlet l:lineList
	unlet l:maxlength
endfunction

