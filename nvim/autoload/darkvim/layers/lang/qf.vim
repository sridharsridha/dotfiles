
function! darkvim#layers#lang#qf#plugins() abort
	let l:plugins = []

	" call add(l:plugins, ['romainl/vim-qf', {
	"			\ 'on_ft' : ['qf'],
	"			\ }])

	call add(l:plugins, ['yssl/QFEnter', {
				\ 'on_ft' : ['qf'],
				\ 'loadconf_before' : 1,
				\ }])

	" call add(l:plugins, ['itchyny/vim-qfedit', {
	"			\ 'on_ft' : ['qf'],
	"			\ }])
	" 
	" call add(l:plugins, ['thinca/vim-qfreplace', {
	"			\ 'on_cmd' : ['Qfreplace'],
	"			\ 'on_ft' : ['qf'],
	"			\ }])

	return l:plugins
endfunction

function! darkvim#layers#lang#qf#config() abort
	let g:qf_max_height = 20
	let g:qf_auto_open_quickfix = 1
	let g:qf_auto_open_loclist = 1
	let g:qf_auto_resize = 1
	let g:qf_mapping_ack_style = 1

	" call darkvim#mapping#space#group(['q'], 'Quickfix')
	" call darkvim#mapping#space#submode('QuikfixN', 'n', 'r', ['q', 'n'], 'n', '<plug>(qf_qf_next)', 'qf-next')
	" call darkvim#mapping#space#submode('QuikfixN', 'n', 'r', ['q', 'p'], 'p', '<plug>(qf_qf_previous)', 'qf-prev')
	" call darkvim#mapping#space#group(['q', 'g'], 'FileGroup')
	" call darkvim#mapping#space#submode('QuikfixF', 'n', 'r', ['q', 'g', 'n'], 'n', '<plug>(qf_next_file)', 'qf-next-fg')
	" call darkvim#mapping#space#submode('QuikfixF', 'n', 'r', ['q', 'g', 'p'], 'p', '<plug>(qf_previous_file)', 'qf-prev-fg')
	" call darkvim#mapping#space#def('nmap', ['q', 't'], '<Plug>(qf_qf_toggle)', 'qf-toggle')
	" call darkvim#mapping#space#def('nmap', ['q', 's'], '<Plug>(qf_qf_switch)', 'qf-window')
	" call darkvim#mapping#space#def('nnoremap', ['q', 'c'], ':call setqflist([])<CR>', 'qf-clear')
	" 
	" call darkvim#mapping#space#group(['q', 'l'], 'LocationList')
	" call darkvim#mapping#space#submode('LocN', 'n', 'r', ['q', 'l', 'n'], 'n', '<plug>(qf_loc_next)', 'll-next')
	" call darkvim#mapping#space#submode('LocN', 'n', 'r', ['q', 'l', 'p'], 'p', '<plug>(qf_loc_previous)', 'll-prev')
	" call darkvim#mapping#space#def('nmap', ['q', 'l', 't'], '<Plug>(qf_loc_toggle)', 'll-goggle')
	" call darkvim#mapping#space#def('nmap', ['q', 'l', 's'], '<Plug>(qf_qf_switch)', 'll-jmmp')
	" call darkvim#mapping#space#def('nnoremap', ['q', 'l', 'c'], ':call setloclist([])<CR>', 'll-clear')

	" call darkvim#mapping#localleader#reg_lang_mappings_cb('qf', function('s:language_specified_mappings'))
endfunction

function! s:language_specified_mappings() abort
endfunction

