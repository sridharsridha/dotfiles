" Ctrlp Layer
function! darkvim#layers#ctrlp#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['ctrlpvim/ctrlp.vim', {
				\ 'on_cmd' : 'CtrlP'}])
	call add(l:plugins, ['FelikZ/ctrlp-py-matcher', {
				\ 'on_source': ['ctrlp.vim']}])
	call add(l:plugins, ['mattn/ctrlp-register', {
				\ 'on_cmd' : 'CtrlPRegister'}])
	call add(l:plugins, ['DeaR/ctrlp-jumps', {
				\ 'on_cmd' : 'CtrlPJump'}])
	call add(l:plugins, ['SpaceVim/vim-ctrlp-help', {
				\ 'on_cmd' : 'CtrlPHelp'}])
	call add(l:plugins, ['hara/ctrlp-colorscheme', {
				\ 'on_cmd' : 'CtrlPColorscheme'}])
	call add(l:plugins, ['ivan-cukic/vim-ctrlp-switcher', {
				\ 'on_cmd' : ['CtrlPSwitch', 'CtrlPSwitchFull', 'CtrlPSwitchBasic']}])

	return l:plugins
endfunction

function! darkvim#layers#ctrlp#config() abort
	if executable('rg')
		set grepprg=rg\ --color=never
		let g:ctrlp_user_command = 'rg %s --hidden --files --color=never -g ""'
	else
		let g:ctrlp_user_command =
					\ 'find %s -type f | grep -v -P "\.git|\.jpg$|/tmp/"' " MacOSX/Linux
	endif

	" caching
	let g:ctrlp_use_caching = 1
	let g:ctrlp_clear_cache_on_exit = 0
	let g:ctrlp_cache_dir = $HOME.'/.cache/darkvim/ctrlp'
	let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25,results:25'
	let g:ctrlp_switch_buffer = 'Et'
	let g:ctrlp_reuse_window = 'startify'
	let g:ctrlp_working_path_mode = 'ra'

	let g:ctrlp_custom_ignore = {
				\ 'dir':  '\v[\/]\.(git|hg|svn)$|target|node_modules|build|cmake-build-debug|te?mp$|logs?$|public$|dist$',
				\ 'file': '\v\.(exe|so|dll|ttf|png|gif|jpe?g|bpm)$|\-rplugin\~',
				\ 'link': 'some_bad_symbolic_links',
				\ }
	let g:ctrlp_prompt_mappings = {
				\ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-g>'],
				\ 'PrtExit()':            ['<esc>', '<c-c>', '<c-s>'],
				\ }
	let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch'  }
	let g:ctrlp_funky_syntax_highlight = get(g:, 'ctrlp_funky_syntax_highlight', 1)
	let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir',
				\ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']


	" Quick access files
	call darkvim#mapping#def('nnoremap <silent><nowait>', '<C-p>',
				\ ":exe 'CtrlP ' . getcwd()<cr>",
				\ 'files-in-current-working-dir')

	call darkvim#mapping#space#group(['f'], 'FuzzyFinder')
	" TODO: implement resume.

	" Buffers
	call darkvim#mapping#space#def('nnoremap', ['f', 'b'],
				\ 'CtrlPBuffer',
				\ 'buffer-list', 1)

	" File listing
	call darkvim#mapping#space#def('nnoremap', ['f', 'r'],
				\ 'CtrlPMixed',
				\ 'open-recent-list', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'f'],
				\ 'CtrlP',
				\ 'files-in-current-buffer-dir', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'p'],
				\ "exe 'CtrlP ' . getcwd()",
				\ 'files-in-current-buffer-dir', 1)

	" Directory
	call darkvim#mapping#space#def('nnoremap', ['f', 'd'],
				\ 'CtrlPDir',
				\ 'list-subdirectories', 1)

	" Register
	call darkvim#mapping#space#def('nnoremap', ['f', 'i'],
				\ 'CtrlPRegister',
				\ 'register', 1)
	" TODO: implement yank.

	" Lines
	call darkvim#mapping#space#def('nnoremap', ['f', 'l'],
				\ 'CtrlPLine',
				\ 'lines', 1)

	" TODO: outlines

	" Lists
	" TODO: locationlist
	call darkvim#mapping#space#def('nnoremap', ['f', 'q'],
				\ 'CtrlPQuickfix',
				\ 'quickfix', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'j'],
				\ 'CtrlPJump',
				\ 'jumplist', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'c'],
				\ 'CtrlPChangeAll',
				\ 'changelist', 1)

	" TODO: Grep


	" TODO: search_history
	" TODO: command_history

	" Colorscheme
	call darkvim#mapping#space#def('nnoremap', ['f', 'C'],
				\ 'CtrlPColorscheme',
				\ 'find-colorschemes', 1)

	" TODO: Commands

	" Tags
	call darkvim#mapping#space#def('nnoremap', ['f', 't'],
				\ 'CtrlPBufTagAll',
				\ 'list-buffer-tags', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'T'],
				\ 'CtrlPTag',
				\ 'list-global-tags', 1)

	" TODO: Marks

	" TODO: keymaps

	" Alternate file
	call darkvim#mapping#space#def('nnoremap', ['f', 'a'],
				\ 'CtrlPSwitchBasic',
				\ 'find-switch-file', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'A'],
				\ 'CtrlPSwitchFull',
				\ 'find-similary-file', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', '?'],
				\ 'CtrlPHelp',
				\ 'find-help', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', '/'],
				\ 'CtrlPClearCache',
				\ 'fuzzy-clear-cache', 1)
endfunction

