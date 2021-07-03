let g:startify_session_dir = $HOME .  '/.data/' . ( has('nvim') ? 'nvim' : 'vim' ) . '/session'
let g:startify_list_order = [
			\ ['   My most recently used files in the current directory:'],
			\ 'dir',
			\ ['   My most recently used files:'],
			\ 'files',
			\ ['   These are my sessions:'],
			\ 'sessions',
			\ ['   These are my bookmarks:'],
			\ 'bookmarks',
			\ ]
let g:startify_update_oldfiles = 1
let g:startify_disable_at_vimenter = 1
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_change_to_dir = 0

let g:startify_skiplist = [
			\ 'COMMIT_EDITMSG',
			\ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
			\ 'bundle/.*/doc',
			\ ]

augroup startify_map
	au!
	autocmd FileType startify nnoremap <buffer> <F2> <Nop>
	autocmd FileType startify setl nowrap
augroup END

