let g:_darkvim_autoclose_filetree = 0
function! s:explore_current_dir(cur) abort
  if !a:cur
    let g:_darkvim_autoclose_filetree = 0
    Defx -no-toggle -no-resume -split=no `getcwd()`
    let g:_darkvim_autoclose_filetree = 1
  else
    Defx -no-toggle
  endif
endfunction

function! s:explore_current_buffer_directory() abort
  Defx `expand('%:p:h') ` -search=`expand('%:p')`
  Defx -new -split=horizontal -direction=
  wincmd p
  exec float2nr(&lines/2) . 'wincmd _'
endfunction


" Defx
call darkvim#mapping#space#group(['d'], 'Directory')
call darkvim#mapping#space#group(['j'], 'Jump')
call darkvim#mapping#space#group(['f'], 'File')
call darkvim#mapping#space#group(['b'], 'Buffer')
call darkvim#mapping#space#group(['r'], 'Resume')

" File tree
call darkvim#mapping#space#def('nnoremap', ['f', 't'], 'Defx', 'toggle-file-tree', 1)
call darkvim#mapping#space#def('nnoremap', ['f', 't'], "Defx  -no-toggle -search=`expand('%:p')` `stridx(expand('%:p'), getcwd()) < 0? expand('%:p:h'): getcwd()`", 'open-file-tree', 1)

" Buffer file tree
call darkvim#mapping#space#def('nnoremap', ['b', 't'], 'exe "Defx -no-toggle " . fnameescape(expand("%:p:h"))', 'show-file-tree-at-buffer-dir', 1)

" Directory file tree
call darkvim#mapping#space#def('nnoremap', ['d', 't'], 'call call('. string(function('s:explore_current_buffer_directory')). ', [])', 'explore_current_buffer_directory', 1)
call darkvim#mapping#space#def('nnoremap', ['r', 't'], 'Defx -resume', 'resume-file-tree', 1)

" Jumps
call darkvim#mapping#space#def('nnoremap', ['j', 'd'], 'call call(' . string(function('s:explore_current_dir')) . ', [0])', 'explore-current-directory', 1)
call darkvim#mapping#space#def('nnoremap', ['j', 'D'], 'call call(' . string(function('s:explore_current_dir')) . ', [1])', 'split-explore-current-directory', 1)
if darkvim#layers#is_loaded('denite')
  call darkvim#mapping#space#def('nnoremap', ['j', 't'], ':Defx<CR>:Denite defx/dirmark<CR>' , 'jump-to-marked-dirs', 0)
endif

