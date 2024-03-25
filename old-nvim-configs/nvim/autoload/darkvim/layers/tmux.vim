" tmux.vim tmux layer for darkvim
function! darkvim#layers#tmux#plugins() abort
	let l:plugins = []

	" Tmux and vim navigation
	" call add(l:plugins, ['christoomey/vim-tmux-navigator', {
	"			\ 'on_cmd': darkvim#util#prefix('TmuxNavigate', ['Left', 'Down', 'Up', 'Right']),
	"			\ }])

	call add(l:plugins, ['christoomey/vim-tmux-navigator', {
            \ 'on_event' : ['BufEnter'],
            \ }])

	" Vim and tmux pane common resize command
	call add(l:plugins, ['RyanMillerC/better-vim-tmux-resizer', {
				\ 'on_cmd': darkvim#util#prefix('TmuxResize', ['Left', 'Down', 'Up', 'Right']),
				\ }])

	" Vim and tmux clipboard sharing
	call add(l:plugins, ['roxma/vim-tmux-clipboard', {
            \ 'on_event' : ['InsertEnter'],
				\ }])

	" tmux config file support
	call add(l:plugins, ['tmux-plugins/vim-tmux', {
				\ 'on_ft' : [ 'tmux' ],
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#tmux#config() abort
	" Disable tmux navigator when zooming the Vim pane
	if exists('$TMUX')
		let g:tmux_navigator_disable_when_zoomed = 1
		let g:tmux_navigator_no_mappings = 1
		nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
		nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
		nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
		nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
      nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

		" Diable tmux resizeer default keymapping and lazy load it
		" using commands
		let g:tmux_resizer_no_mappings = 1
		nnoremap <silent> <M-h> :TmuxResizeLeft<cr>
		nnoremap <silent> <M-j> :TmuxResizeDown<cr>
		nnoremap <silent> <M-k> :TmuxResizeUp<cr>
		nnoremap <silent> <M-l> :TmuxResizeRight<cr>
	else
		nnoremap <silent> <C-h> <C-w>h
		nnoremap <silent> <C-j> <C-w>j
		nnoremap <silent> <C-k> <C-w>k
		nnoremap <silent> <C-l> <C-w>l
	endif
endfunction
