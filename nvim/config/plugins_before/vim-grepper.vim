
" Vim-Grepper
let g:grepper = {}
let g:grepper.open = 1
let g:grepper.quickfix = 1
let g:grepper.searchreg = 1
let g:grepper.switch = 1
let g:grepper.highlight = 1
let g:grepper.tools = ['rg', 'ag', 'grep']
let g:grepper.prompt_text = g:darkvim_commandline_prompt . ' '

call darkvim#mapping#space#group(['s'], 'Search')
call darkvim#mapping#g#def('nmap', ['s'],
			\ '<plug>(GrepperOperator)',
			\ 'grep-selection', 2, 1)
call darkvim#mapping#space#def('nnoremap', ['s', 's'],
			\ 'Grepper',
			\ 'search-in-project', 1)
call darkvim#mapping#space#def('nnoremap', ['s', 'S'],
			\ 'Grepper -cword -noprompt',
			\ 'search-cwords-in-project', 1)


