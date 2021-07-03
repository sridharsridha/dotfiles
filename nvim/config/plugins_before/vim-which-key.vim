" Which-Key toplevel mappings, no guide need for these mappings
nnoremap <silent> z :<c-u>WhichKey 'z'<CR>
nnoremap <silent><nowait> g :<c-u>WhichKey 'g'<CR>
exe 'nnoremap <silent> ' . g:darkvim_windows_leader .
			\ " :<c-u>WhichKey '" . g:darkvim_windows_leader . "'<CR>"

nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual ','<CR>

nnoremap <silent> <localleader> :<c-u>WhichKey '\'<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual '\'<CR>

nnoremap <silent> <space> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <space> :<c-u>WhichKeyVisual '<Space>'<CR>
