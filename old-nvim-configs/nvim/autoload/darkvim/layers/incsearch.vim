
function! darkvim#layers#incsearch#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['haya14busa/incsearch.vim'])
	call add(l:plugins, ['haya14busa/incsearch-fuzzy.vim'])
	call add(l:plugins, ['haya14busa/vim-asterisk'])
	call add(l:plugins, ['osyo-manga/vim-over'])
	call add(l:plugins, ['haya14busa/incsearch-easymotion.vim'])

	return l:plugins
endfunction

function! darkvim#layers#incsearch#config() abort
	map /  <Plug>(incsearch-forward)
	map ?  <Plug>(incsearch-backward)
	map g/ <Plug>(incsearch-stay)
	set hlsearch
	let g:incsearch#no_inc_hlsearch = 1
	let g:incsearch#auto_nohlsearch = get(g:, 'incsearch#auto_nohlsearch', 1)
	nnoremap <silent> n  :call <SID>update_search_index('d')<cr>
	nnoremap <silent> N  :call <SID>update_search_index('r')<cr>
	map *  <Plug>(incsearch-nohl-*)
	map #  <Plug>(incsearch-nohl-#)
	map g* <Plug>(incsearch-nohl-g*)
	map g# <Plug>(incsearch-nohl-g#)
	function! s:config_fuzzyall(...) abort
		return extend(copy({
					\   'converters': [
					\     incsearch#config#fuzzy#converter(),
					\     incsearch#config#fuzzyspell#converter()
					\   ],
					\ }), get(a:, 1, {}))
	endfunction
	function! s:config_easyfuzzymotion(...) abort
		return extend(copy({
					\   'converters': [incsearch#config#fuzzy#converter()],
					\   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
					\   'keymap': {"\<CR>": '<Over>(easymotion)'},
					\   'is_expr': 0,
					\   'is_stay': 1
					\ }), get(a:, 1, {}))
	endfunction
	call darkvim#mapping#space#def('nmap', ['b', '/'], '<Plug>(incsearch-fuzzyword-/)',
				\ 'fuzzy find word')
endfunction

let s:si_flag = 0
function! s:update_search_index(key) abort
	if a:key ==# 'd'
		if mapcheck('<Plug>(incsearch-nohl-n)') !=# ''
			call feedkeys("\<Plug>(incsearch-nohl-n)")
		else
			normal! n
		endif
	elseif a:key ==# 'r'
		if mapcheck('<Plug>(incsearch-nohl-N)') !=# ''
			call feedkeys("\<Plug>(incsearch-nohl-N)")
		else
			normal! N
		endif
	endif
	normal! ml
	normal! `l
endfunction
