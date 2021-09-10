scriptencoding utf-8

" Change the shape of the cursor according to the current mode.
" Only works in iTerm with or without tmux.
" See http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
" if !empty($TMUX)
"   " Inside a tmux session.
"   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"   let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
"   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" else
"   " Not inside a tmux session.
"   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"   let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" endif

if g:darkvim_enable_guicolors == 1
  set t_Co=256
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  elseif exists('+guicolors')
    set guicolors
  endif
  try
    exec 'set background=dark'
    exec 'colorscheme ' . g:darkvim_colorscheme
  catch
    exec 'colorscheme desert'
  endtry
else
  try
    exec 'set background=dark'
    exec 'colorscheme ' . g:darkvim_colorscheme
  catch
    exec 'colorscheme desert'
  endtry
endif

