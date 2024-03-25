" Better-whitespace
let g:better_whitespace_ctermcolor = 203
let g:better_whitespace_guicolor = '#ff5f5f'
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0
let g:strip_only_modified_lines = 1

function! s:delete_extra_space() abort
  if !empty(getline('.'))
    if getline('.')[col('.')-1] ==# ' '
      execute "normal! \"_ciw\<Space>\<Esc>"
    endif
  endif
endfunction

call darkvim#mapping#space#group(['x'], 'Text')
call darkvim#mapping#space#group(['x', 'd'], 'delete')
call darkvim#mapping#space#def('nnoremap', ['x', 'd', 'w'], 'StripWhitespace', 'delete trailing whitespaces', 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'd', '<Space>'], 'silent call call('
			\ . string(function('s:delete_extra_space')) . ', [])',
			\ 'delete extra space arround cursor', 1)
