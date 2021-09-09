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
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_theme=g:darkvim_colorscheme
endfunction
