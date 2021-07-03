" Tagbar
call darkvim#mapping#space#group(['t'], 'Tags')
call darkvim#mapping#space#def('nnoremap', ['t', 'w'],
			\ 'TagbarToggle',
			\ 'open-tagbar-window', 1)
