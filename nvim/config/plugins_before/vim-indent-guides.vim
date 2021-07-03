" IndentLine
call darkvim#mapping#space#group(['h'], 'Highlight')
call darkvim#mapping#space#def('nnoremap', ['h', 'i'],
\ 'IndentGuidesToggle',
\ 'toggle-highlight-indentation-levels', 1)

