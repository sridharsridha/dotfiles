" Quickhl
call darkvim#mapping#space#group(['h'], 'Highlight')
call darkvim#mapping#space#group(['h', 'w'], 'Word')
call darkvim#mapping#space#def('nmap', ['h', 'w', 'r'],
			\ '<Plug>(quickhl-manual-reset)',
			\ 'highlight-reset', 0, 1)
call darkvim#mapping#space#def('nmap', ['h', 'w', 'w'],
			\ '<Plug>(quickhl-manual-this)',
			\ 'highlight-word', 0, 1)
call darkvim#mapping#space#def('nmap', ['h', 'w', 'c'],
			\ '<Plug>(quickhl-manual-clear)',
			\ 'highlight-clear', 0, 1)
call darkvim#mapping#space#def('nmap', ['h', 'w', 'h'],
			\ '<Plug>(quickhl-cword-toggle)',
			\ 'highlight-cword-toggle', 0, 1)

