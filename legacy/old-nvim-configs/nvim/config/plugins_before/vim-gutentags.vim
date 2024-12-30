" Gutentags
call darkvim#mapping#space#group(['t'], 'Tags')
call darkvim#mapping#space#def('nnoremap', ['t', 'u'],
			\ 'GutentagsUpdate!',
			\ 'update-tags-proj', 1)
call darkvim#mapping#space#def('nnoremap', ['t', 'U'],
			\ 'GutentagsUpdate',
			\ 'update-tags-file', 1)
