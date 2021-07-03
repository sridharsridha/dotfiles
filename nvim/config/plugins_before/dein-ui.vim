call darkvim#mapping#space#group(['p'], 'PackageManager')
call darkvim#mapping#space#def('nnoremap', ['p', 'u'],
			\ 'DeinUpdate',
			\ 'update-plugins', 1)
