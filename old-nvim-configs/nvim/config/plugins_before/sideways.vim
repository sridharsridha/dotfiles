" Sideways
call darkvim#mapping#space#group(['c'], 'Code')
call darkvim#mapping#space#group(['c', 's'], 'ListItem')
call darkvim#mapping#space#def('nnoremap', ['c', 's', 'h'],
			\ 'SidewaysLeft',
			\ 'shift-list-item-left', 1)
call darkvim#mapping#space#def('nnoremap', ['c', 's', 'l'],
			\ 'SidewaysRight',
			\ 'shift-list-item-right', 1)
