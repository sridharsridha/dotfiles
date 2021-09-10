" core.vim core plugins for darkvim
scriptencoding utf-8

function! darkvim#layers#core#plugins() abort
	let l:plugins = []

	" Show a help screen for keymap
	call add(l:plugins, [ 'liuchengxu/vim-which-key', {
				\ 'on_cmd' : darkvim#util#prefix('WhichKey', ['', 'Visual', '!', 'Visual!']),
				\ 'loadconf' : 1,
				\ 'loadconf_before': 1,
				\ }])

	" Toggle search highlights automatically
	call add(l:plugins, ['romainl/vim-cool', {
				\ 'on_event' : ['BufReadPost'],
				\ 'loadconf_before' : 1,
				\ }])

	" Highlight jump
	call add(l:plugins, ['deris/vim-shot-f', {
				\ 'on_map' : { 'nxo' : '<Plug>' },
				\ 'loadconf' : 1,
				\ 'loadconf_before' : 1,
				\ }])

	" Trigger a mode with a keymap and repeat it using another keymap.
	call add(l:plugins, ['kana/vim-submode', {
				\ 'loadconf' : 1,
				\ 'nolazy' : 1,
				\ }])

	" . operator repeat
	call add(l:plugins, ['tpope/vim-repeat'])

	" Context filetype support
	call add(l:plugins, ['Shougo/context_filetype.vim'])

	" Operator global plugin
	call add(l:plugins, ['kana/vim-operator-user'])

	" TextObj globla plugins
	call add(l:plugins, ['kana/vim-textobj-user'])

	" Icons
	call add(l:plugins, ['ryanoasis/vim-devicons', {
				\ 'nolazy' : 1,
				\ }])

	" Capture command output to a buffer
	call add(l:plugins, ['tyru/capture.vim', {
				\ 'on_cmd' : ['Capture'],
				\ }])

	" Plugin Manager Wrapper
	call add(l:plugins, ['haya14busa/dein-command.vim', {
				\ 'on_cmd' : ['Dein'],
				\ 'loadconf_before' : 1,
				\ }])

	" Dein ui
	call add(l:plugins, ['wsdjeg/dein-ui.vim', {
				\ 'on_cmd' : ['DeinUpdate'],
				\ 'loadconf_before' : 1,
				\ }])

	" Commenter
	call add(l:plugins, ['tyru/caw.vim', {
				\ 'on_map' : {'nvx' : '<Plug>'},
				\ 'loadconf_before' : 1,
				\ }])

	" Browser helper
	call add(l:plugins, ['tyru/open-browser.vim', {
				\ 'on_cmd' : darkvim#util#prefix('OpenBrowser', ['SmartSearch', '', 'Search']),
				\ 'on_map' : {'nx' : '<Plug>(openbrowser-'},
				\ 'loadconf_before' : 1,
				\ }])

	" Choose window by visual selection
	call add(l:plugins, ['t9md/vim-choosewin', {
				\ 'on_map' : {'ni' : '<Plug>'},
				\ 'on_cmd' : darkvim#util#prefix('ChooseWin', ['', 'Swap']),
				\ }])

	" Colorscheme
	call add(l:plugins, ['morhetz/gruvbox', {
				\ 'nolazy' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#core#config() abort
endfunction

