" main.vim --- Main file for darkvim
" Author: Sridhar Nagarajan ( sridha.in@gmail.com )
" Date: 2019:11:28
" License: None

let g:_darkvim_root_dir = escape(fnamemodify(resolve(fnamemodify(expand('<sfile>'),
      \ ':p:h:h:gs?\\?'.'/?')), ':p:gs?[\\/]?/?'), ' ')
lockvar g:_darkvim_root_dir
let &runtimepath = g:_darkvim_root_dir . ',' . $VIMRUNTIME

call darkvim#start()
call darkvim#end()
