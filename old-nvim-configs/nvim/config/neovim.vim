" https://github.com/syngan/vim-vimlint/issues/102
function! s:has(version) abort
  return has(a:version)
endfunction

" " dark0 + gray
" let g:terminal_color_0 = '#282828'
" let g:terminal_color_8 = '#928374'
" 
" " neurtral_red + bright_red
" let g:terminal_color_1 = '#cc241d'
" let g:terminal_color_9 = '#fb4934'
" 
" " neutral_green + bright_green
" let g:terminal_color_2 = '#98971a'
" let g:terminal_color_10 = '#b8bb26'
" 
" " neutral_yellow + bright_yellow
" let g:terminal_color_3 = '#d79921'
" let g:terminal_color_11 = '#fabd2f'
" 
" " neutral_blue + bright_blue
" let g:terminal_color_4 = '#458588'
" let g:terminal_color_12 = '#83a598'
" 
" " neutral_purple + bright_purple
" let g:terminal_color_5 = '#b16286'
" let g:terminal_color_13 = '#d3869b'
" 
" " neutral_aqua + faded_aqua
" let g:terminal_color_6 = '#689d6a'
" let g:terminal_color_14 = '#8ec07c'
" 
" " light4 + light1
" let g:terminal_color_7 = '#a89984'
" let g:terminal_color_15 = '#ebdbb2'

" augroup Terminal
"   au!
"   au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
"   " au WinEnter,BufWinEnter term://* startinsert
"   if has('timers')
"     au TermClose * let g:_darkvim_termclose_abuf = expand('<abuf>') | call timer_start(5, 'darkvim#mapping#windows#close_term')
"   else
"     au TermClose * let g:_darkvim_termclose_abuf = expand('<abuf>') | call darkvim#mapping#windows#close_term()
"   endif
" augroup END
" 
" augroup nvimrc_aucmd
"   autocmd!
"   autocmd CursorHold,FocusGained,FocusLost * rshada|wshada
" augroup END

