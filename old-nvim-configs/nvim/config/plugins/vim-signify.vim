let g:signify_disable_by_default = 0
let g:signify_line_highlight = 0

let g:signify_vcs_list      = [ 'git', 'perforce' ]
let g:signify_vcs_cmds = {
  \ 'git':      'git diff --no-color --no-ext-diff -U0 -- %f',
  \ 'perforce': 'a4 info '. sy#util#shell_redirect('%n') . (has('win32') ? ' &&' : ' && env P4DIFF= P4COLORS=') .' a4 diff -du 0 %f',
  \ }
let g:signify_vcs_cmds_diffmode = {
  \ 'git':      'git show HEAD:./%f',
  \ 'perforce': 'a4 print %f',
  \ }

let g:signify_cursorhold_insert     = 1
let g:signify_cursorhold_normal     = 1
let g:signify_update_on_bufenter    = 0
let g:signify_update_on_focusgained = 1

" signify: don't show number of lines that were removed
let g:signify_sign_show_count = 0

" signify: use heavier signs (probably unnecessary on retina displays)
let g:signify_sign_add               = '✚'
let g:signify_sign_delete            = '▁'

let g:signify_sign_delete_first_line = '▔'
let g:signify_sign_change            = '•' " options: ! ≠ • ~

call darkvim#mapping#space#group(['v'], 'VersionControl')
call darkvim#mapping#space#def('nnoremap', ['v', 'r'], 'SignifyRefresh',
      \ 'signify-refresh', 1)

call darkvim#mapping#space#group(['v', 'h'], 'Hunks')
call darkvim#mapping#space#def('nnoremap', ['v', 'h', 'd'], 'SignifyHunkDiff',
      \ 'signify-hunk-diff', 1)
call darkvim#mapping#space#def('nnoremap', ['v', 'h', 'u'], 'SignifyHunkUndo',
      \ 'signify-hunk-undo', 1)

" hunk jumping
call darkvim#mapping#space#def('nmap', ['v', 'h', 'n'], '<plug>(signify-next-hunk)',
      \ 'signify-hunk-next', 1)
call darkvim#mapping#space#def('nmap', ['v', 'h', 'p'], '<plug>(signify-prev-hunk)',
      \ 'signify-hunk-prev', 1)
call darkvim#mapping#space#def('nmap', ['v', 'h', 'N'], '<plug>(signify-prev-hunk)',
      \ 'signify-hunk-prev', 1)


" hunk text object
omap igs <plug>(signify-motion-inner-pending)
xmap igs <plug>(signify-motion-inner-visual)
omap ags <plug>(signify-motion-outer-pending)
xmap ags <plug>(signify-motion-outer-visual)
