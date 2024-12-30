" format.vim format layer for darkvim

function! darkvim#layers#format#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['neoformat/neoformat',
				\ {'on_cmd' : ['Neoformat'],
				\ 'loadconf' : 1,
				\ 'loadconf_before' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#format#config() abort
	call darkvim#mapping#space#group(['c'], 'Code')
	call darkvim#mapping#space#def('nnoremap', ['c', 'F'], 'call call('.string(function('s:toggle_auto_format')).', [])', 'toggle-auto-format', 1)
endfunction

function! s:toggle_auto_format() abort
  if !exists('#AutoFormatCode#BufWritePre')
    augroup AutoFormatCode
      autocmd!
      autocmd BufWritePre * undojoin | Neoformat
    augroup END
  else
    augroup AutoFormatCode
      autocmd!
    augroup END
  endif
endfunction
