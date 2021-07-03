" Statusline layers for darkvim
scriptencoding utf8

function! darkvim#layers#core#statusline#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['vim-airline/vim-airline', {
				\ 'nolazy' : 1,
				\ }])
	call add(l:plugins, ['vim-airline/vim-airline-themes', {
				\ 'nolazy' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#core#statusline#config() abort
	" Airline
	let g:airline_theme=g:darkvim_colorscheme
	" Short form mode text
	let g:airline_mode_map = {
				\ '__' : '-',
				\ 'n'  : 'N',
				\ 'i'  : 'I',
				\ 'R'  : 'R',
				\ 'c'  : 'C',
				\ 'v'  : 'V',
				\ 'V'  : 'V-L',
				\ '' : 'V-B',
				\ 's'  : 'S',
				\ 'S'  : 'S-L',
				\ '' : 'S-B',
				\ 't'  : 'T',
				\ 'ic' : 'IC',
				\ 'ix' : 'IC',
				\ 'ni' : '(I)',
				\ 'no' : 'O-P',
				\ }
endfunction
