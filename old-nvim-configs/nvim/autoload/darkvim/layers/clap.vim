" clap Layer
function! darkvim#layers#clap#plugins() abort
	let l:plugins = []
	" call clap#installer#build_maple()
	call add(l:plugins, ['liuchengxu/vim-clap', {
				\ 'on_cmd' : ['Clap'],
				\ 'do': [':Clap install-binary!',
				\ ':call clap#installer#build_maple()']}])
	return l:plugins
endfunction

function! darkvim#layers#clap#config() abort
	let g:clap_cache_directory = $HOME.'/.cache/darkvim/clap'
	" let g:clap_theme = 'material_design_dark'
	let g:clap_layout = { 'width' : '90%', 'col' : '5%' }
	let g:clap_enable_icon = 1
	" let g:clap_search_box_border_style = 'curve'
	let g:clap_provider_grep_enable_icon = 1
	" let g:clap_prompt_format = '%spinner%%forerunner_status% %provider_id%: '
	" highlight! link ClapMatches Function
	" highlight! link ClapNoMatchesFound WarningMsg

	augroup clap_init
		autocmd!
		autocmd FileType clap_input call s:clap_mappings()
	augroup END

	" Quick access files
	call darkvim#mapping#def('nnoremap <silent><nowait>', '<C-p>',
				\ ':Clap! files<cr>',
				\ 'files-in-current-working-dir')

	call darkvim#mapping#space#group(['f'], 'FuzzyFinder')

	" TODO: implement resume

	" Buffers
	call darkvim#mapping#space#def('nnoremap', ['f', 'b'],
				\ 'Clap buffers',
				\ 'buffer-list', 1)

	" Files listing
	call darkvim#mapping#space#def('nnoremap', ['f', 'r'],
				\ 'Clap history',
				\ 'open-recent-list', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'f'],
				\ 'Clap files',
				\ 'files-in-current-buffer-dir', 1)

	" TODO: implement directory listing provider for clap.

	call darkvim#mapping#space#def('nnoremap', ['f', 'e'],
				\ 'Clap filer',
				\ 'open-file-tree', 1)

	" Register
	call darkvim#mapping#space#def('nnoremap', ['f', 'i'],
				\ 'Clap register',
				\ 'register', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'y'],
				\ 'Clap yanks',
				\ 'yank-history', 1)

	" Lines
	call darkvim#mapping#space#def('nnoremap', ['f', 'l'],
				\ 'Clap lines',
				\ 'lines', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'L'],
				\ 'Clap lines ++query=<cword>',
				\ 'lines-cursor-word', 1)

	" TODO: Outline

	" Lists
	call darkvim#mapping#space#def('nnoremap', ['f', 'c'],
				\ 'Clap loclist' ,
				\ 'loc-list', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'q'],
				\ 'Clap quickfix',
				\ 'quickfix', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'j'],
				\ 'Clap jump',
				\ 'jumplist', 1)
	" TODO: implement changelist

	" Grep
	call darkvim#mapping#space#def('nnoremap', ['f', 's'],
				\ 'Clap grep ++query=<cword>',
				\ 'search-cursor-word', 1)
	call darkvim#mapping#space#def('vnoremap', ['f', 's'],
				\ 'Clap grep ++query=@visual',
				\ 'search-cursor-word', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'g'],
				\ 'Clap grep',
				\ 'grep', 1)
	" Faster grep with maple binary build using o
	call darkvim#mapping#space#def('nnoremap', ['f', 'S'],
				\ 'Clap grep2 ++query=<cword>',
				\ 'faster-search-cursor-word', 1)
	call darkvim#mapping#space#def('vnoremap', ['f', 'S'],
				\ 'Clap grep2 ++query=@visual',
				\ 'faster-search-cursor-word', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'G'],
				\ 'Clap grep2',
				\ 'faster-grep', 1)

	" History
	call darkvim#mapping#space#def('nnoremap', ['f', 'H'],
				\ 'Clap hist/',
				\ 'search-history', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'H'],
				\ 'Clap hist:',
				\ 'command-history', 1)

	" Colorscheme
	call darkvim#mapping#space#def('nnoremap', ['f', 'C'],
				\ 'Clap color',
				\ 'colorschemes', 1)

	" Command
	call darkvim#mapping#space#def('nnoremap', ['f', 'x'],
				\ 'Clap command',
				\ 'commands', 1)

	" Tags
	call darkvim#mapping#space#def('nnoremap', ['f', 't'],
				\ 'Clap tags',
				\ 'tags', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', '?'],
				\ 'Clap help_tags',
				\ 'help-tags', 1)

	" Marks
	call darkvim#mapping#space#def('nnoremap', ['f', 'm'],
				\ 'Clap marks',
				\ 'marks', 1)

	" Keymaps
	call darkvim#mapping#space#def('nnoremap', ['f', 'k'],
				\ 'Clap maps',
				\ 'keymappings', 1)
endfunction

function! s:clap_mappings() abort
	nnoremap <silent> <buffer> <nowait>' :call clap#handler#tab_action()<CR>
	nnoremap <silent> <buffer> <C-f> :<c-u>call clap#navigation#scroll('down')<CR>
	nnoremap <silent> <buffer> <C-b> :<c-u>call clap#navigation#scroll('up')<CR>
	nnoremap <silent> <buffer> sg  :<c-u>call clap#handler#try_open('ctrl-v')<CR>
	nnoremap <silent> <buffer> sv  :<c-u>call clap#handler#try_open('ctrl-x')<CR>
	nnoremap <silent> <buffer> st  :<c-u>call clap#handler#try_open('ctrl-t')<CR>
	nnoremap <silent> <buffer> <c-j> :<c-u>call clap#navigation#linewise('down')<CR>
	nnoremap <silent> <buffer> <c-k> :<c-u>call clap#navigation#linewise('up')<CR>
	nnoremap <silent> <buffer> q     :<c-u>call clap#handler#exit()<CR>
	nnoremap <silent> <buffer> <Esc> :call clap#handler#exit()<CR>

	inoremap <silent> <buffer> <Esc> <C-R>=clap#navigation#linewise('down')<CR><C-R>=clap#navigation#linewise('up')<CR><Esc>
	inoremap <silent> <buffer> jk    <C-R>=clap#navigation#linewise('down')<CR><C-R>=clap#navigation#linewise('up')<CR><Esc>
endfunction
