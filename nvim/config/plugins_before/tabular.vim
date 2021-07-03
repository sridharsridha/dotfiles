scriptencoding utf-8

" Tablular
call darkvim#mapping#space#group(['x'], 'Text')
call darkvim#mapping#space#group(['x', 'a'], 'Align')
call darkvim#mapping#space#def('nnoremap', ['x', 'a', '#'], 'Tabularize /#', 'align-region-at-#', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', '%'], 'Tabularize /%', 'align-region-at-%', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', '&'], 'Tabularize /&', 'align-region-at-&', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', '('], 'Tabularize /(', 'align-region-at-(', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', ')'], 'Tabularize /)', 'align-region-at-)', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', '['], 'Tabularize /[', 'align-region-at-[', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', ']'], 'Tabularize /]', 'align-region-at-]', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', '{'], 'Tabularize /{', 'align-region-at-{', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', '}'], 'Tabularize /}', 'align-region-at-}', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', ','], 'Tabularize /,', 'align-region-at-,', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', '.'], 'Tabularize /.', 'align-region-at-.', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', ':'], 'Tabularize /:', 'align-region-at-:', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', ';'], 'Tabularize /;', 'align-region-at-;', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', '='], 'Tabularize /===\|<=>\|\(&&\|||\|<<\|>>\|\/\/\)=\|=\~[#?]\?\|=>\|[:+/*!%^=><&|.?-]\?=[#?]\?/l1r1', 'align-region-at-=', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', 'o'], 'Tabularize /&&\|||\|\.\.\|\*\*\|<<\|>>\|\/\/\|[-+*/.%^><&|?]/l1r1', 'align-region-at-operator, such as +,-,*,/,%,^,etc', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', '¦'], 'Tabularize /¦', 'align-region-at-¦', 1, 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'a', '<Bar>'], 'Tabularize /|', 'align-region-at-|', 1, 1)
call darkvim#mapping#space#def('nmap', ['x', 'a', 's'], 'Tabularize /\s\ze\S/l0', 'align-region-at-space', 1, 1)

function! s:align_at_regular_expression() abort
	let l:re = input(':Tabularize /')
	if !empty(l:re)
		exe 'Tabularize /' . l:re
	else
		normal! :
		echo 'empty input, canceled!'
	endif
endfunction
call darkvim#mapping#space#def('nnoremap', ['x', 'a', 'r'], 'call call(' . string(function('s:align_at_regular_expression')) . ',[])', 'align-region-at-user-specified-regexp', 1, 1)
