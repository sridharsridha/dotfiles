" tools.vim --- darkvim tools layer
function! darkvim#layers#tools#plugins() abort
  let l:plugins = []


  " Highlight words under cursor
  " Fancy start screen
 "  call add(l:plugins, ['mhinz/vim-startify', {
	"\ 'on_cmd' : ['Startify'],
	"\ 'loadconf' : 1,
	"\ }])


  " Profile startuptime
  call add(l:plugins, ['tweekmonster/startuptime.vim', {
	\ 'on_cmd' : ['StartupTime'],
	\ }])

  " Cheat
 "  call add(l:plugins, ['dbeniamine/cheat.sh-vim', {
	"\ 'name': 'cheat_sheet',
	"\ 'on_func': ['cheat#cheat'],
	"\ }])

  " Grammer checker
 "  call add(l:plugins, ['rhysd/vim-grammarous', {
	"\ 'on_cmd': [ 'GrammarousCheck' ],
	"\ }])

  " Scratch window
 "  call add(l:plugins, ['mtth/scratch.vim', {
	"\ 'on_cmd': darkvim#util#prefix('Scratch',
	"\              ['', 'Insert', 'Selection', 'Preview']),
	"\ }])
 "  call add(l:plugins, ['chrisbra/NrrwRgn', {
	"\ 'on_cmd': ['NUD', 'NR', 'NW']
	"\ }])

  " Resize window automatically on switching
  call add(l:plugins, ['justincampbell/vim-eighties', {
	\ 'on_cmd': darkvim#util#prefix('TmuxNavigate', ['Left', 'Down', 'Up', 'Right']),
	\ 'loadconf': 1,
	\ }])

 "  " Shell tools
  call add(l:plugins, ['tpope/vim-eunuch', {
	\ 'on_cmd' : ['Delete', 'Unlink', 'Move', 'Rename', 'Chmod', 'Mkdir',
	\             'Cfind', 'Clocate', 'Lfind', 'Llocate', 'Wall',
	\             'SudoWrite', 'SudoEdit'],
	\ }])

  " Quickrun
  call add(l:plugins, ['thinca/vim-quickrun', {
	\ 'on_cmd': ['QuickRun'],
	\ 'loadconf_before': 1,
	\ }])

  return l:plugins
endfunction

function! darkvim#layers#tools#config() abort

  " Startify
  call darkvim#mapping#space#group(['a'], 'Applications')
 "  call darkvim#mapping#space#def('nnoremap', ['a','S'],
	"\ 'Startify | doautocmd WinEnter',
	"\ 'open-fancy-start-screen', 1)

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

  " Cheatsheet
 "  let g:CheatSheetFt = 'cheatsheet'
 "  let g:CheatSheetShowCommentsByDefault = 1
 "  let g:CheatSheetDefaultSelection = 'line'
 "  let g:CheatSheetDefaultMode = 0
 "  let g:CheatSheetIdPath = '/tmp/cht.sh/id' " I hate cookies.
 "  let g:CheatSheetDoNotMap = 1
 "  let g:CheatDoNotReplaceKeywordPrg = 1
 "  call darkvim#mapping#space#group(['a', 'c'], 'Cheat')
 "  call darkvim#mapping#space#def('nnoremap', ['a', 'c', 'c'],
	"\ 'call cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 0, "!")',
	"\ 'search-current-line-cheat.sh (open-new-win)', 1)
 "  call darkvim#mapping#space#def('nnoremap', ['a', 'c', 'r'],
	"\ 'call cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 1, "!")',
	"\ 'search-current-line-cheat.sh (rep-cur-line)', 1)
 "  call darkvim#mapping#space#def('nnoremap', ['a', 'c', 'r'],
	"\ 'call cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 1, "!")',
	"\ 'search-current-line-cheat.sh (rep-cur-line)', 1)
 "  call darkvim#mapping#space#def('nnoremap', ['a', 'c', 'e'],
	"\ 'call cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 1, "!")',
	"\ 'search-first-error-cheat.sh (open-new-win)', 1)
 "  call darkvim#mapping#space#def('nnoremap', ['a', 'c', 'C'],
	"\ 'call cheat#navigate(0, "C")',
	"\ 'remove-comments-of-cheat.sh-replacement', 1)

  " Grammarous
 "  let g:grammarous#info_window_height = 10
 "  let g:grammarous#info_window_direction = 'botleft'
 "  let g:grammarous#use_vim_spelllang = 1
 "  let g:grammarous#move_to_first_error = 1
 "  let g:grammarous#show_to_first_error = 1
 "  let g:grammarous#default_comments_only_filetypes = {
	"\ '*' : 1,
	"\ 'tex': 0,
	"\ 'texplain': 0,
	"\ 'markdown' : 0,
	"\ 'help' : 0
	"\ }
 "  call darkvim#mapping#space#group(['a', 'g'], 'Grammar')
 "  call darkvim#mapping#space#def('nnoremap', ['a', 'g', 'g'],
	"\ 'GrammarousCheck',
	"\ 'start-check-grammar', 1)
 "  call darkvim#mapping#space#def('nmap', ['a', 'g', 'R'],
	"\ '<Plug>(grammarous-reset)',
	"\ 'reset-last-check-grammar')
 "  call darkvim#mapping#space#def('nmap', ['a', 'g', 'o'],
	"\ '<Plug>(grammarous-open-info-window)',
	"\ 'open-grammer-check-result-window')
 "  call darkvim#mapping#space#def('nmap', ['a', 'g', 'c'],
	"\ '<Plug>(grammarous-close-info-window)',
	"\ 'close-grammar-check-result-window')
 "  call darkvim#mapping#space#def('nmap', ['a', 'g', 'n'],
	"\ '<Plug>(grammarous-move-to-next-error)',
	"\ 'jump-to-next-grammar-check-error')
 "  call darkvim#mapping#space#def('nmap', ['a', 'g', 'N'],
	"\ '<Plug>(grammarous-move-to-previous-error)',
	"\ 'jump-to-previous-grammar-check-error')
 "  call darkvim#mapping#space#def('nmap', ['a', 'g', 'p'],
	"\ '<Plug>(grammarous-move-to-previous-error)',
	"\ 'jump-to-previous-grammar-check-error')
 "  call darkvim#mapping#space#def('nmap', ['a', 'g', 'f'],
	"\ '<Plug>(grammarous-fixit)<Plug>(grammarous-move-to-next-error)',
	"\ 'autofix-current-error-and-jump-to-next')
 "  call darkvim#mapping#space#def('nmap', ['a', 'g', 'r'],
	"\ '<Plug>(grammarous-remove-error)<Plug>(grammarous-move-to-next-error)',
	"\ 'remove/ignore-current-error-and-jump-to-next')

  " Scratch window
 "  let g:scratch_autohide = 1
 "  let g:scratch_filetype = 'markdown'
 "  let g:scratch_height = 10
 "  let g:scratch_top = 1
 "  let g:scratch_horizontal = 1
 "  let g:scratch_no_mappings = 1
 "  let g:scratch_persistence_file = g:darkvim_plugin_bundle_dir . '/scratch.md'
 "  call darkvim#mapping#space#group(['a', 'e'], 'Scratch')
 "  call darkvim#mapping#space#def('nnoremap', ['a', 'e', 'e'],
	"\ 'Scratch',
	"\ 'open-scratch-pad', 1)
 "  call darkvim#mapping#space#def('nnoremap', ['a', 'e', 'p'],
	"\ 'ScratchPreview',
	"\ 'open-scratch-pad-in-preview-window', 1)

endfunction
