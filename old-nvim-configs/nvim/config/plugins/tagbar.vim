scriptencoding utf-8

let g:tagbar_autoshowtag = 1
let g:tagbar_width = get(g:, 'darkvim_tagbar_width', 40)
if get(g:,'darkvim_filetree_direction', 'right') ==# 'right'
  let g:tagbar_left = 0
else
  let g:tagbar_left = 1
endif
" Also use h/l to open/close folds
let g:tagbar_map_closefold = ['h', '-', 'zc']
let g:tagbar_map_openfold = ['l', '+', 'zo']
let g:tagbar_sort = get(g:, 'tagbar_sort', 0)
let g:tagbar_compact = get(g:, 'tagbar_compact', 1)
let g:tagbar_map_showproto = get(g:, 'tagbar_map_showproto', '')
let g:tagbar_iconchars = ['▶', '▼']


