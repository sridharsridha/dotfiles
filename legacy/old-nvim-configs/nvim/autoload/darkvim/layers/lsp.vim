" lsp.vim LanguageServerProtocol support layer for darkvim
" Uses coc.nvim

function! darkvim#layers#lsp#plugins() abort
	let l:plugins = []

	" Echo doc of current api
	call add(l:plugins, ['Shougo/echodoc.vim', {
				\ 'on_cmd' : darkvim#util#prefix('EchoDoc', ['Enable', 'Disable']),
				\ 'on_event' : 'CompleteDone',
				\ 'loadconf' : 1,
				\ }])

	" Complete parameters
	call add(l:plugins, ['tenfyzhong/CompleteParameter.vim', {
				\ 'on_event' : 'InsertEnter',
				\ }])
	if has('nvim-0.5.0')
		" Language server protocal client intergration support
		call add(l:plugins, ['neoclide/coc.nvim', {
					\ 'merged': 0,
					\ 'rev': 'release',
					\ 'build' : './install.sh',
					\ 'hook_post_update' : 'call coc#util#install()',
					\ 'on_event' : 'InsertEnter',
					\ 'loadconf' : 1,
					\ }])
	endif

	" Snippet support
	call add(l:plugins, ['honza/vim-snippets'])
	call add(l:plugins, ['Shougo/neosnippet-snippets'])
	call add(l:plugins,  ['Shougo/neosnippet.vim', {
				\ 'depends' : ['neosnippet-snippets', 'vim-snippets'],
				\ 'on_event' : 'InsertEnter',
				\ 'loadconf' : 1,
				\ }])

	" Not sure if I need this need to check
	call add(l:plugins, ['Shougo/neco-syntax', {
				\ 'on_event' : 'InsertEnter',
				\ }])
	call add(l:plugins, ['Shougo/neopairs.vim', {
				\ 'on_event' : 'InsertEnter',
				\ }])

	" Demlimter
	call add(l:plugins, ['Raimondi/delimitMate', {
				\ 'on_event' : 'InsertEnter',
				\ 'loadconf' : 1,
				\ }])

	" Symbol tree
	" Airline has some issue with lazy loading this plugin
	call add(l:plugins, ['liuchengxu/vista.vim', {
				\ 'on_event' : 'InsertEnter',
				\ 'loadconf' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#lsp#config() abort
	let g:coc_disable_startup_warning = 1

	" Vista
	let g:vista_sidebar_width = 35
	let g:vista_echo_cursor_strategy = 'floating_win'
	let g:vista_highlight_whole_line = 1
	let g:vista_echo_cursor = 1
	let g:vista_blink = [2, 500]
	let g:vista_stay_on_open = 0
	let g:vista_cursor_delay = 800

	" let g:complete_parameter_use_ultisnips_mapping = 1

	imap <expr> <M-/> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : ""

	imap <silent><expr><C-j>
				\ complete_parameter#jumpable(1) && getline('.')[col('.')-2] !=# ')' ?
				\ "\<plug>(complete_parameter#goto_next_parameter)" : "\<C-j>"
	imap <silent><expr><C-k>
				\ complete_parameter#jumpable(1) ?
				\ "\<plug>(complete_parameter#goto_previous_parameter)" : "\<C-k>"
	imap <expr>(
				\ pumvisible() ?
				\ complete_parameter#pre_complete("()") :
				\ (len(maparg('<Plug>delimitMate(', 'i')) == 0) ?
				\ "\<Plug>delimitMate(" :
				\ '('

	smap <expr><TAB>
				\ neosnippet#expandable_or_jumpable() ?
				\ "\<Plug>(neosnippet_expand_or_jump)" :
				\ (complete_parameter#jumpable(1) ?
				\ "\<plug>(complete_parameter#goto_next_parameter)" :
				\ "\<TAB>")
	imap <silent><expr><TAB> darkvim#layers#lsp#tab()
	imap <silent><expr><S-TAB> darkvim#layers#lsp#shift_tab()
	imap <silent><expr><CR> darkvim#layers#lsp#enter()


	" Remap keys for gotos
	call darkvim#mapping#g#def('nmap', ['d'],
				\ '<Plug>(coc-definition)',
				\ 'jump-to-definition', 2)
	call darkvim#mapping#g#def('nmap', ['y'],
				\ '<Plug>(coc-type-definition)',
				\ 'jump-to-type-definition', 2)
	call darkvim#mapping#g#def('nmap', ['b'],
				\ '<Plug>(coc-declaration)',
				\ 'jump-to-declination', 2)
	call darkvim#mapping#g#def('nmap', ['i'],
				\ '<Plug>(coc-implementation)',
				\ 'jump-to-implementation', 2)
	call darkvim#mapping#g#def('nmap', ['r'],
				\ '<Plug>(coc-references)',
				\ 'jump-to-references', 2)
	call darkvim#mapping#g#def('nmap', ['h'],
				\ "call CocActionAsync('highlight')",
				\ 'highlight-symbol', 1)

	" Use K to show documentation in preview window
	nnoremap <silent> K :call darkvim#layers#lsp#show_documentation()<CR>

	if has('nvim-0.5.0')
		augroup lsp_custom
			autocmd!
			" Update signature help on jump placeholder
			autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
		augroup end
	endif

	call darkvim#mapping#space#group(['l'], 'LSP')
	call darkvim#mapping#space#group(['l', 'g'], 'GlobalOptions')
	call darkvim#mapping#space#def('nmap', ['l', 'g', 'I'],
				\ 'CocInstall',
				\ 'install-plugins', 1)
	call darkvim#mapping#space#def('nmap', ['l', 'g', 'u'],
				\ 'CocUpdate',
				\ 'update-plugins', 1)
	call darkvim#mapping#space#def('nmap', ['l', 'g', 's'],
				\ 'CocUpdateSync',
				\ 'update-sync-plugins', 1)
	call darkvim#mapping#space#def('nmap', ['l', 'g', 'c'],
				\ 'CocCommand',
				\ 'update-sync-plugins', 1)
	call darkvim#mapping#space#def('nmap', ['l', 'g', 'a'],
				\ 'CocAction',
				\ 'codeactions', 1)
	call darkvim#mapping#space#def('nmap', ['l', 'g', 'f'],
				\ 'CocFix',
				\ 'quickfix-actions', 1)
	call darkvim#mapping#space#def('nmap', ['l', 'g', 'l'],
				\ 'CocOpenLog',
				\ 'open-log-file', 1)
	call darkvim#mapping#space#def('nmap', ['l', 'g', 'i'],
				\ 'CocInfo',
				\ 'information', 1)
	call darkvim#mapping#space#def('nmap', ['l', 'g', 'r'],
				\ 'CocRestart',
				\ 'restart', 1)
	call darkvim#mapping#space#def('nmap', ['l', 'g', 'g'],
				\ 'CocConfig',
				\ 'config', 1)

	" Vista
	call darkvim#mapping#space#def('nmap', ['l', 't'],
				\ 'Vista',
				\ 'symbol-tree', 1)

	" Links
	call darkvim#mapping#space#def('nmap', ['l', 'O'],
				\ '<Plug>(coc-openlink)',
				\ 'open-link-under-cursor', 2)

	" Use `:Format` to format current buffer
	command! -nargs=0 Format :call CocAction('format')

	call darkvim#mapping#space#group(['l', 'f'], 'Format')
	call darkvim#mapping#space#def('nmap', ['l', 'f', 's'],
				\ '<Plug>(coc-format-selected)',
				\ 'format-selected-code', 2, 1)
	call darkvim#mapping#space#def('xmap', ['l', 'f', 's'],
				\ '<Plug>(coc-format-selected)',
				\ 'format-selected-code', 2, 1)
	call darkvim#mapping#space#def('nmap', ['l', 'f', 'f'],
				\ '<Plug>(coc-format)',
				\ 'format-buffer', 2)

	" Use `:Fold` to fold current buffer
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" Actions and fix
	call darkvim#mapping#space#group(['l', 'a'], 'Actions')
	call darkvim#mapping#space#def('nmap', ['l', 'a', 's'],
				\ '<Plug>(coc-codeaction-selected)',
				\ 'run-code-action-on-selected', 2, 1)
	call darkvim#mapping#space#def('xmap', ['l', 'a', 's'],
				\ '<Plug>(coc-codeaction-selected)',
				\ 'run-code-action-on-selected', 2, 1)
	call darkvim#mapping#space#def('nmap', ['l', 'a', 'l'],
				\ '<Plug>(coc-codeaction)',
				\ 'run-code-action-on-current-line', 2)
	call darkvim#mapping#space#def('nmap', ['l', 'a', 'a'],
				\ '<Plug>(coc-codelens-action)',
				\ 'do-codelens-cmd-current-line', 2)
	call darkvim#mapping#space#def('nmap', ['l', 'a', 'f'],
				\ '<Plug>(coc-fix-current)',
				\ 'fix-current-line-issue', 2)
	call darkvim#mapping#space#def('nnoremap', ['l', 'a', 'n'],
				\ 'CocNext',
				\ 'do-default-action-for-previous-item', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'a', 'p'],
				\ 'CocPrev',
				\ 'do-default-action-for-next-item', 1)

	" Refactor
	call darkvim#mapping#space#group(['l', 'r'], 'Refractor')
	call darkvim#mapping#space#def('nmap', ['l', 'r', 'r'],
				\ '<Plug>(coc-rename)',
				\ 'rename-symbol', 2)
	call darkvim#mapping#space#def('nmap', ['l', 'r', 's'],
				\ '<Plug>(coc-refactor)',
				\ 'refactor-symbol', 2)


	" Diagnostics
	call darkvim#mapping#space#group(['l', 'd'], 'Diagnostics')
	call darkvim#mapping#space#def('nmap', ['l', 'd', 'n'],
				\ '<Plug>(coc-diagnostic-next)',
				\ 'next-diagnostics-message', 2)
	call darkvim#mapping#space#def('nmap', ['l', 'd', 'p'],
				\ '<Plug>(coc-diagnostic-prev)',
				\ 'prev-diagnostics-message', 2)
	call darkvim#mapping#space#def('nmap', ['l', 'd', 'N'],
				\ '<Plug>(coc-diagnostic-next-error)',
				\ 'next-diagnostics-error', 2)
	call darkvim#mapping#space#def('nmap', ['l', 'd', 'P'],
				\ '<Plug>(coc-diagnostic-prev-error)',
				\ 'prev-diagnostics-error', 2)
	call darkvim#mapping#space#def('nmap', ['l', 'd', 'e'],
				\ '<Plug>(coc-diagnostic-info)',
				\ 'explain-the-error', 2)

	" CocList
	call darkvim#mapping#space#group(['l', 'l'], 'Lists')
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'l'],
				\ 'CocListResume',
				\ 'list-resume', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 't'],
				\ 'CocList templates',
				\ 'select-file-header-template', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'd'],
				\ 'CocList diagnostics',
				\ 'list-diagnostics', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'e'],
				\ 'CocList extensions',
				\ 'list-extensions', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'o'],
				\ 'CocList -A outline',
				\ 'list-outline', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'c'],
				\ 'CocList command',
				\ 'do-codelens-cmd-current-line', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 's'],
				\ 'CocList -I symbols',
				\ 'list-symbols', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'y'],
				\ 'CocList -A --normal yank',
				\ 'list-symbols', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'l'],
				\ 'CocList links',
				\ 'links', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'b'],
				\ 'CocList buffers',
				\ 'buffers', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'm'],
				\ 'CocList mru',
				\ 'mru', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'h'],
				\ 'CocList helptags',
				\ 'helptags', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'p'],
				\ 'CocList files',
				\ 'files-project-root', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'f'],
				\ "exe 'CocList --input='.expand('%:p:h:t').'/ files'",
				\ 'files-project-root', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'g'],
				\ 'CocList -A -I grep',
				\ 'grep-symbols', 1)
	call darkvim#mapping#space#def('nnoremap', ['l', 'l', 'G'],
				\ "exe 'CocList -A -I --input='.expand('<cword>').' grep'",
				\ 'grep-cword', 1)
endfunction

function! darkvim#layers#lsp#check_back_space() abort
	let l:col = col('.') - 1
	return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunction

function! darkvim#layers#lsp#tab() abort
	if neosnippet#expandable() && getline('.')[col('.')-2] ==# '(' && !pumvisible()
		return "\<Plug>(neosnippet_expand)"
	elseif neosnippet#jumpable()
				\ && getline('.')[col('.')-2] ==# '(' && !pumvisible()
				\ && !neosnippet#expandable()
		return "\<plug>(neosnippet_jump)"
	elseif neosnippet#expandable_or_jumpable() && getline('.')[col('.')-2] !=#'('
		return "\<plug>(neosnippet_expand_or_jump)"
	elseif pumvisible()
		return "\<C-n>"
	elseif complete_parameter#jumpable(1) && getline('.')[col('.')-2] !=# ')'
		return "\<plug>(complete_parameter#goto_next_parameter)"
	elseif darkvim#layers#lsp#check_back_space()
		return "\<tab>"
	else
		call coc#refresh()
		return "\<tab>"
	endif
endfunction

function! darkvim#layers#lsp#check_back_space() abort
	let l:col = col('.') - 1
	return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunction-

function! darkvim#layers#lsp#enter() abort
	if exists('*complete_info') && complete_info()['selected'] !=# '-1'
		return "\<C-y>"
	else
		if pumvisible()
			return neosnippet#expandable() ? "\<plug>(neosnippet_expand)" : "\<C-y>"
		endif
	endif
	return "\<Plug>delimitMateCR"
endfunction

function! darkvim#layers#lsp#shift_tab() abort
	return pumvisible() ? "\<C-p>" : "\<Plug>delimitMateS-Tab"
endfunction

function! darkvim#layers#lsp#show_documentation() abort
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

