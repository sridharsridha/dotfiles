function! darkvim#layers#highlights#plugins() abort
	let l:plugins = []
	" Match paren
				"\ 'on_cmd' : ['MatchupWhereAmI'],
				"\ 'loadconf': 1,
	call add(l:plugins, ['andymass/vim-matchup', {
				\ 'nolazy' : 1,
				\ }])

	" info window
	call add(l:plugins, ['mcchrish/info-window.nvim', {
				\ 'on_cmd': ['InfoWindowToggle'],
				\ 'on_func': ['infowindow#toggle'],
				\ }])

	call add(l:plugins, ['t9md/vim-quickhl' , {
				\ 'on_map' : {'nx' : '<Plug>(quickhl'},
				\ 'loadconf_before' : 1,
				\ }])

	call add(l:plugins, ['MattesGroeger/vim-bookmarks', {
				\ 'loadconf' : 1,
				\ 'loadconf_before' : 1,
				\ 'nolazy' : 1,
				\ }])

	" Show indent line highlight
	"
				"\ 'on_cmd' : darkvim#util#prefix('IndentGuides', ['Enable', 'Toggle']),
	call add(l:plugins, ['nathanaelkane/vim-indent-guides', {
				\ 'nolazy' : 1,
				\ 'loadconf_before' : 1,
				\ }])

	" Whitespace showing
	call add(l:plugins, ['ntpeters/vim-better-whitespace', {
				\ 'on_event' : ['InsertEnter'],
				\ 'on_cmd' : ['StripWhitespace',
				\             'ToggleWhitespace',
				\             'DisableWhitespace',
				\             'EnableWhitespace'],
				\ 'loadconf_before' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#highlights#config() abort

	" Info window
	" Toggle info window for current buffer
	nnoremap <silent> <C-g> <cmd>call infowindow#toggle()<CR>:MatchupWhereAmI?<CR>

endfunction
