" Dein command keymapping
call darkvim#mapping#space#group(['p'], 'PackageManager')
call darkvim#mapping#space#def('nnoremap', ['p', 'r'], ':Dein recache-runtimepath<CR>', 'recache-runtimepath', 0)
call darkvim#mapping#space#def('nnoremap', ['p', 'i'], 'Dein install', 'install-plugins', 1)
call darkvim#mapping#space#def('nnoremap', ['p', 'c'], 'Dein clean', 'clean-plugins', 1)
call darkvim#mapping#space#def('nnoremap', ['p', 'l'], 'Capture Dein list', 'list-plugins', 1)
call darkvim#mapping#space#def('nnoremap', ['p', 'p'], 'Denite dein', 'fuzzy-installed-plugins', 1)
call darkvim#mapping#space#def('nnoremap', ['p', 'u'], 'Dein update', 'update-plugins', 1)
