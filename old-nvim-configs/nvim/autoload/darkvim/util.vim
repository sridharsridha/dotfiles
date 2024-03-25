" source a vimscript file
function! darkvim#util#load_config(file) abort
	if filereadable(g:_darkvim_root_dir. '/config/' . a:file)
		execute 'source ' . g:_darkvim_root_dir  . '/config/' . a:file
	endif
endfunction

" Prefix str to args and return the map
function! darkvim#util#prefix(str, args) abort
    return map(a:args, {_, s -> a:str . s})
endfunction

" Sufix str to args and return the map
function! darkvim#util#suffix(str, args) abort
    return map(a:args, {_, s -> s . a:str})
endfunction

" Cached executable() implemention)
let s:has_exec_cache = {}
function! darkvim#util#has_exec(command) abort
    if !has_key(s:has_exec_cache, a:command)
        let s:has_exec_cache[a:command] = executable(a:command)
    endif
    return s:has_exec_cache[a:command]
endfunction

" Find if given text in sart of line
function! darkvim#util#is_start_of_line(mapping) abort
	let l:text_before_cursor = getline('.')[0 : col('.')-1]
	let l:mapping_pattern = '\V' . escape(a:mapping, '\')
	let l:comment_pattern = '\V' . escape(substitute(&l:commentstring,
				\ '%s.*$', '', ''), '\')
	return (l:text_before_cursor =~? '^' . ('\v(' . l:comment_pattern . '\v)?') .
				\ '\s*\v' . l:mapping_pattern . '\v$')
endfunction

function! darkvim#util#find_file_explorer() abort
  " Detect terminal file-explorer
  let s:file_explorer = get(g:, 'darkvim_terminal_file_explorer', '')
  if empty(s:file_explorer)
    for l:explorer in ['lf', 'hunter', 'ranger', 'vifm']
      if executable(l:explorer)
        let s:file_explorer = l:explorer
        break
      endif
    endfor
  endif
  return s:file_explorer
endfunction

" Split tmux and run a command on the given dir
function! darkvim#util#tmux_split_run(cmd, cwd) abort
    if empty('$TMUX')
        return
    endif
    if a:cwd ==# ''
        let l:cwd = getcwd()
    else
        let l:cwd = a:cwd
    endif
   silent execute '!tmux split-window -p 30 -c '. l:cwd . ' ' . a:cmd | redraw!
endfunction

function! darkvim#util#visual_selection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

