" git.vim git layer for darkvim

function! darkvim#layers#git#plugins() abort
	let l:plugins = []

	" Git support
	call add(l:plugins, ['lambdalisue/gina.vim', {
				\ 'on_cmd' : ['Gina'],
				\ }])

	" Signcolumn marker
	call add(l:plugins, ['mhinz/vim-signify', {
				\ 'on_cmd' : darkvim#util#prefix('Signify', ['Diff', 'Toggle', 'ToggleHighlight']),
				\ 'loadconf' : 1,
				\ }])


	" List git log of current file
	call add(l:plugins, ['cohama/agit.vim', {
				\ 'on_cmd' : darkvim#util#prefix('Agit', ['', 'File']),
				\ }])

	" Gist support
	call add(l:plugins, ['lambdalisue/vim-gista', {
				\ 'on_cmd' : ['Gista'],
				\ }])

	" Show git blame in floating window
	call add(l:plugins, ['rhysd/git-messenger.vim', {
				\ 'on_cmd' : ['GitMessenger'],
				\ 'on_map' : '<Plug>(git-messenger',
				\ 'loadconf' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#git#config() abort
	" Gina ( git wrapper )
	call darkvim#mapping#space#group(['g'], 'Git')
	call darkvim#mapping#space#def('nnoremap', ['g', 's'],
				\ 'Gina status --opener=30split',
				\ 'git-status', 1)

	" Staging
	call darkvim#mapping#space#def('nnoremap', ['g', 'A'],
				\ 'Gina add .',
				\ 'stage-all-files', 1)
	call darkvim#mapping#space#def('nnoremap', ['g', 'a'],
				\ 'Gina add %',
				\ 'stage-current-file', 1)
	call darkvim#mapping#space#def('nnoremap', ['g', 'u'],
				\ 'Gina reset -q %',
				\ 'unstage-current-file', 1)

	" Transfers
	call darkvim#mapping#space#def('nnoremap', ['g', 'c'],
				\ 'Gina commit',
				\ 'edit-git-commit', 1)
	call darkvim#mapping#space#def('nnoremap', ['g', 'p'],
				\ 'Gina push',
				\ 'git-push', 1)
	call darkvim#mapping#space#def('nnoremap', ['g', 'r'],
				\ 'Gina pull',
				\ 'git-rebase', 1)

	" Git messager
	call darkvim#mapping#space#def('nnoremap', ['g', 'b'],
				\ 'GitMessenger',
				\ 'show-git-blame-for-current-line-in-floating-window', 1)
	call darkvim#mapping#space#def('nnoremap', ['g', 'B'],
				\ 'Gina blame',
				\ 'view-git-blame', 1)

	" Git branch
	call darkvim#mapping#space#def('nnoremap', ['g', 't'],
				\ 'Gina branch --opener=10split',
				\ 'list-git-branch', 1)

	" Agit (git log)
	call darkvim#mapping#space#def('nnoremap', ['g', 'l'],
				\ 'AgitFile',
				\ 'open-git-log-current-file(new tab)', 1)
	call darkvim#mapping#space#def('nnoremap', ['g', 'L'],
				\ 'Agit',
				\ 'open-git-log-repo(new tab)', 1)

	" Highlight
	call darkvim#mapping#space#def('nnoremap', ['g', 'h'],
				\ 'SignifyEnable',
				\ 'signify-toggle', 1)
	call darkvim#mapping#space#def('nnoremap', ['g', 'H'],
				\ 'SignifyToggleHighlight',
				\ 'signify-toggle-line-highlight', 1)

	" Diff
	call darkvim#mapping#space#group(['g', 'd'], 'Diffs')
	call darkvim#mapping#space#def('nnoremap', ['g', 'd', 'u'],
				\ 'Gina diff',
				\ 'git-diff-unified', 1)
	call darkvim#mapping#space#def('nnoremap', ['g', 'd', 'd'],
				\ 'SignifyDiff',
				\ 'signify-diff', 1)
	call darkvim#mapping#space#def('nnoremap', ['g', 'd', 'h'],
				\ 'SignifyHunkDiff',
				\ 'signify-hunk-diff', 1)

	" Display last commit
	call darkvim#mapping#space#def('nnoremap', ['g', 'M'],
				\ 'call call(' . string(function('s:disp_last_commit_curline')) . ', [])',
				\ 'commit-message-of-current-line', 1)

	" Gista ( Gist wrapper )
	call darkvim#mapping#space#group(['g', 'g'], 'Gist')
	call darkvim#mapping#space#def('nnoremap', ['g', 'g', 'l'],
				\ 'Gista list',
				\ 'list-gist', 1)
	call darkvim#mapping#space#def('nnoremap', ['g', 'g', 'p'],
				\ 'Gista post',
				\ 'post-selection-or-current-file', 1, 1)

	augroup darkvim_layer_git
		autocmd!
		" Instead of reverting the cursor to the last position in the buffer, we
		" set it to the first line when editing a git commit message
		au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
	augroup END
endfunction

function! s:disp_last_commit_curline() abort
	let l:line = line('.')
	let l:file = expand('%')
	let l:cmd = 'git log -L ' . l:line . ',' . l:line . ':' . l:file
	let l:cmd .= ' --pretty=format:"%s" -1'
	let l:title = systemlist(l:cmd)[0]
	if v:shell_error == 0
		echo 'Last commit of current line is: ' . l:title
	endif
endfunction

