"Use jk switch to normal mode
inoremap jk <esc>

" Replace
nnoremap R "_d"

" Start new line
inoremap <S-Return> <C-o>o

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
			\ 'zt' : (winline() == &scrolloff + 1) ? 'zb' : 'zz'

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting in visual mode
nnoremap > >>_
nnoremap < <<_

" smart up and down
nnoremap <silent><Down> gj
nnoremap <silent><Up> gk

" Start an external command with a single bang
nnoremap Y y$

" The plugin rhysd/accelerated-jk moves through display-lines in normal mode,
" these mappings will move through display-lines in visual mode too.
vnoremap j gj
vnoremap k gk

" Start an external command with a single bang
nnoremap !  :!

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

imap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
imap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
imap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
imap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" Unimpaired bindings
" Quickly add empty lines
call darkvim#mapping#space#group(['x'], 'Text')
call darkvim#mapping#space#group(['x', 'l'], 'Line')
call darkvim#mapping#space#def('nnoremap', ['x', 'l', 'a'],
			\ 'put! =repeat(nr2char(10), v:count1)',
			\ 'add-empty-line-below', 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'l', 'b'],
			\ 'put =repeat(nr2char(10), v:count1)',
			\ 'add-empty-line-above', 1)

" Switch (window) to the directory of the current opened buffer
call darkvim#mapping#space#group(['d'], 'Directory')
call darkvim#mapping#space#def('nnoremap', ['d', 'c'],
			\ 'lcd %:p:h<CR>:pwd',
			\ 'cd-current-buffer-dir', 1)
" Yank buffer's relative/absolute path to clipboard
nnoremap <Space>dY :let @+=expand('%:~:.')<CR>:echo 'Yanked relative path'<CR>
let g:_darkvim_mappings_space['d']['Y'] = 'yank-relative-path-current-buffer'
nnoremap <Space>dy :let @+=expand('%:p')<CR>:echo 'Yanked absolute path'<CR>
let g:_darkvim_mappings_space['d']['y'] = 'yank-absolute-path-current-buffer'

" Smart wrap toggle (breakindent and colorcolumn toggle as-well)
call darkvim#mapping#leader#group(['t'], 'Toggles')
" nmap <leader>tw :execute('setlocal wrap! breakindent! colorcolumn=' . (&colorcolumn == '' ? &textwidth : ''))<CR>
call darkvim#mapping#leader#def('nmap', ['t', 'w'],
			\ 'execute("setlocal wrap! breakindent! colorcolumn=" . (&colorcolumn == "" ? &textwidth : ""))',
			\ 'toggle-wrap', 1)
" let g:_darkvim_mappings_leader['t']['w'] = 'toggle-wrap'
call darkvim#mapping#leader#def('nnoremap', ['t', 's'],
			\ 'setlocal spell!',
			\ 'toggle-spell', 1)
call darkvim#mapping#leader#def('nnoremap', ['t', 'n'],
			\ 'setlocal nonumber!',
			\ 'toggle-number', 1)
call darkvim#mapping#leader#def('nnoremap', ['t', 'c'],
			\ 'setlocal nocursorline!',
			\ 'toggle-cursorline', 1)
call darkvim#mapping#leader#def('nnoremap', ['t', 'l'],
			\ 'setlocal nolist!',
			\ 'toggle-list', 1)
call darkvim#mapping#leader#def('nnoremap', ['t', 'h'],
			\ 'setlocal nohlsearch!',
			\ 'toggle-search-highlight', 1)
call darkvim#mapping#leader#def('nnoremap', ['t', 'p'],
			\ 'setlocal paste!',
			\ 'toggle-paste', 1)
" toggles the quickfix window.
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
	if exists('g:qfix_win') && a:forced == 0
		cclose
	else
		execute 'copen ' . get(g:, 'darkvim_quickfix_winheight', 15)
	endif
endfunction
" used to track the quickfix window
augroup QFixToggle
	autocmd!
	autocmd BufWinEnter quickfix let g:qfix_win = bufnr('$')
	autocmd BufWinLeave * if exists('g:qfix_win') && expand('<abuf>') == g:qfix_win |
				\ unlet! g:qfix_win | endif
augroup END
call darkvim#mapping#leader#def('nnoremap', ['t', 'q'],
			\ 'QFix',
			\ 'toggle-quickfix-window', 1)


