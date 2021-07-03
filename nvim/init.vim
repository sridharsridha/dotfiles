" File              : init.vim
" License           : None
" Author            : Sridhar Nagarajan <sridha.in@gmail.com>
" Date              : 03.01.2020
" Last Modified Date: 03.01.2020
" Last Modified By  : Sridhar Nagarajan <sridha.in@gmail.com>

if !exists('g:vscode')
	let g:coc_force_debug = 1
	execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'
else

endif

