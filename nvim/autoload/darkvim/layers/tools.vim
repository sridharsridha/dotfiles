" tools.vim --- darkvim tools layer
function! darkvim#layers#tools#plugins() abort
	let l:plugins = []

	" Fancy start screen
	call add(l:plugins, ['mhinz/vim-startify', {
				\ 'nolazy' : 1,
				\ 'loadconf' : 1,
				\ }])


	" Profile startuptime
	call add(l:plugins, ['tweekmonster/startuptime.vim', {
				\ 'on_cmd' : ['StartupTime'],
				\ }])

	" Resize window automatically on switching
	call add(l:plugins, ['justincampbell/vim-eighties', {
				\ 'on_cmd': darkvim#util#prefix('TmuxNavigate', ['Left', 'Down', 'Up', 'Right']),
				\ 'loadconf': 1,
				\ }])

	" Shell tools
	" call add(l:plugins, ['tpope/vim-eunuch', {
	"			\ 'on_cmd' : ['Delete', 'Unlink', 'Move', 'Rename', 'Chmod', 'Mkdir',
	"			\             'Cfind', 'Clocate', 'Lfind', 'Llocate', 'Wall',
	"			\             'SudoWrite', 'SudoEdit'],
	"			\ }])

	" Quickrun
	call add(l:plugins, ['thinca/vim-quickrun', {
				\ 'on_cmd': ['QuickRun'],
				\ 'loadconf_before': 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#tools#config() abort

	call darkvim#mapping#space#group(['a'], 'Applications')

	" StartupTime profile
	call darkvim#mapping#space#def('nnoremap', ['a', 'p'],
				\ 'StartupTime',
				\ 'profile-startuptime', 1)

	" Alternate files
	call darkvim#mapping#space#group(['j'], 'Jump')
	call darkvim#mapping#space#group(['j', 'a'], 'AlternateFile')
	call darkvim#mapping#space#def('nnoremap', ['j', 'a', 'a'],
				\ 'A',
				\ 'open', 1)
	call darkvim#mapping#space#def('nnoremap', ['j', 'a', 'v'],
				\ 'AV',
				\ 'open-vertical-split', 1)
	call darkvim#mapping#space#def('nnoremap', ['j', 'a', 'g'],
				\ 'AS',
				\ 'open-horizontal-split', 1)
	call darkvim#mapping#space#submode('AltFile', 'n', '', ['j', 'a', 'n'], 'n',
				\ ':AN<cr>',
				\ 'next-alt-file (enter submode n)')

endfunction
