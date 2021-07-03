call darkvim#mapping#space#group(['s'], 'Search')
call darkvim#mapping#space#def('nnoremap', ['s', 'v'],
			\ 'Grepper -side',
			\ 'search-in-project-vsplit-output', 1)
call darkvim#mapping#space#def('nnoremap', ['s', 'V'],
			\ 'Grepper -cword -noprompt -side',
			\ 'search-cwords-in-project-vsplit-output', 1)
call darkvim#mapping#space#def('nnoremap', ['s', 'b'],
			\ 'Grepper -buffers',
			\ 'search-in-buffers', 1)
call darkvim#mapping#space#def('nnoremap', ['s', 'b'],
			\ 'Grepper -buffers -cword --nopromt',
			\ 'search-cword-in-buffers', 1)
