augroup darkvim_core
  au!
  autocmd Syntax *
        \ if line('$') > 1000 | syntax sync minlines=300 | endif
  autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
        \   q :cclose<cr>:lclose<cr>
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
  autocmd BufNewFile,BufEnter * set cpoptions+=d " NOTE: ctags find the tags file from the current path instead of the path of currect file
  autocmd BufWinLeave * let b:_winview = winsaveview()
  autocmd BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
  autocmd BufWritePre * call darkvim#plugins#mkdir#create_current()
  autocmd SessionLoadPost * let g:_darkvim_session_loaded = 1
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd InsertLeave *
        \ if &paste | setlocal nopaste | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif
  autocmd BufEnter * let b:_darkvim_project_name = get(g:, '_darkvim_project_name', '')
  autocmd BufEnter,FileType * call darkvim#mapping#localleader#refresh_lang_mappings()
  autocmd BufWritePre /tmp/*          setlocal noundofile
  autocmd BufWritePre COMMIT_EDITMSG  setlocal noundofile
  autocmd BufWritePre MERGE_MSG       setlocal noundofile
  autocmd BufWritePre *.tmp           setlocal noundofile
  autocmd BufWritePre *.bak           setlocal noundofile
augroup END

