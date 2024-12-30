call darkvim#mapping#space#group(['h'], 'Highlight')
call darkvim#mapping#space#group(['h', 'm'], 'Marks')

call darkvim#mapping#space#def('nnoremap', ['h', 'm', 'm'], 'BookmarkToggle', 'toggle-mark', 1)
call darkvim#mapping#space#def('nnoremap', ['h', 'm', 'i'], 'BookmarkAnnotate', 'annotate-mark', 1)
call darkvim#mapping#space#def('nnoremap', ['h', 'm', 'm'], 'BookmarkShowAll', 'show-all', 1)

call darkvim#mapping#space#submode2('BookmarkN', 'n', '', ['h', 'm', 'n'], ':BookmarkNext<CR>', 'next-mark')
call darkvim#mapping#space#submode_map('BookmarkN', 'n', '', 'n', ':BookmarkNext<cr>')
call darkvim#mapping#space#submode_map('BookmarkN', 'n', '', 'p', ':BookmarkPrev<cr>')

call darkvim#mapping#space#submode2('BookmarkP', 'n', '', ['h', 'm', 'p'], ':BookmarkPrev<CR>', 'prev-mark')
call darkvim#mapping#space#submode_map('BookmarkP', 'n', '', 'n', ':BookmarkNext<cr>')
call darkvim#mapping#space#submode_map('BookmarkP', 'n', '', 'p', ':BookmarkPrev<cr>')

call darkvim#mapping#space#def('nnoremap', ['h', 'm', 'c'], 'BookmarkClear', 'clear-mark', 1)
call darkvim#mapping#space#def('nnoremap', ['h', 'm', 'x'], 'BookmarkClearAll', 'clear-all-mark', 1)

