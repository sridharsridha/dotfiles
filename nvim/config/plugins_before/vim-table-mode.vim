
" Table Mode trigger and disabling while in insert mode
inoreabbrev <expr> <bar><bar>
			\ darkvim#util#is_start_of_line('\|\|')?
			\ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
			\ darkvim#util#is_start_of_line('__')?
			\ '<c-o>:silent! TableModeDisable<cr>' : '__'

