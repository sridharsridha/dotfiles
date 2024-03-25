" cmake.vim : cmake file support for darkvim
function! darkvim#layers#lang#cmake#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['cdelledonne/vim-cmake', {
				\ 'on_cmd' : darkvim#util#prefix('Cmake',
				\            ['Generate', 'Clean', 'Build', 'Open', 'Close']),
				\ 'on_map' : {'n' : '<Plug>(CMake'},
				\ }])
	call add(l:plugins, ['pboettch/vim-cmake-syntax', {
				\ 'on_ft' : ['cmake'],
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#lang#cmake#config() abort
	let g:cmake_link_compile_commands = 1
	call darkvim#mapping#space#group(['m'], 'Make')
	call darkvim#mapping#space#def('nmap', ['m', 'g'], 'CMakeGenerate', 'generate-cmake-build-files', 1)
	call darkvim#mapping#space#def('nnoremap', ['m', 'c'], 'CMakeClean', 'clean-cmake-project', 1)
	call darkvim#mapping#space#def('nnoremap', ['m', 'b'], 'CMakeBuild --parallel 7', 'build-cmake-project', 1)
	call darkvim#mapping#space#def('nmap', ['m', 'B'], '<Plug>(CMakeBuildTarget)', 'build-cmake-target')
	call darkvim#mapping#space#def('nmap', ['m', 'i'], 'CMakeInstall', 'install-cmake-project', 2)

	call darkvim#mapping#space#def('nnoremap', ['m', 'o'], 'call call(' . string(function('s:toggle_cmake_console')) . ', [])', 'toggle-cmake-console', 1)
	call darkvim#mapping#space#def('nnoremap', ['m', 'a'], 'call call(' . string(function('s:cmake_auto_reload')) . ', [1])', 'enable-cmake-auto-reload', 1)
	call darkvim#mapping#space#def('nnoremap', ['m', 'A'], 'call call(' . string(function('s:cmake_auto_reload')) . ', [0])', 'disable-cmake-auto-reload', 1)
	call s:cmake_auto_reload(0)
endfunction

function! s:toggle_cmake_console() abort
	let l:cmake_console_windows = filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") ==# "vimcmake"')
	if len(l:cmake_console_windows) == 0
		execute 'CMakeOpen'
	else
		execute 'CMakeClose'
	endif
endfunction

function! s:cmake_auto_reload(enabled) abort
	augroup cmake_custom
		au!
		if a:enabled
			au BufWritePost CMakeLists.txt execute 'CMakeGenerate'
		endif
	augroup END
endfunction

