"=============================================================================
" file.vim --- darkvim file API
"=============================================================================
scriptencoding utf-8
let s:file = {}
let s:system = darkvim#api#import('system')
let s:vim_comp = darkvim#api#import('vim#compatible')

if s:system.isWindows
	let s:file['separator'] = '\'
	let s:file['pathSeparator'] = ';'
else
	let s:file['separator'] = '/'
	let s:file['pathSeparator'] = ':'
endif

let s:file_node_extensions = {
			\  'styl'     : '',
			\  'scss'     : '',
			\  'htm'      : '',
			\  'html'     : '',
			\  'erb'      : '',
			\  'slim'     : '',
			\  'ejs'      : '',
			\  'wxml'      : '',
			\  'css'      : '',
			\  'less'     : '',
			\  'wxss'     : '',
			\  'md'       : '',
			\  'markdown' : '',
			\  'json'     : '',
			\  'js'       : '',
			\  'jsx'      : '',
			\  'rb'       : '',
			\  'php'      : '',
			\  'py'       : '',
			\  'pyc'      : '',
			\  'pyo'      : '',
			\  'pyd'      : '',
			\  'coffee'   : '',
			\  'mustache' : '',
			\  'hbs'      : '',
			\  'conf'     : '',
			\  'ini'      : '',
			\  'yml'      : '',
			\  'bat'      : '',
			\  'jpg'      : '',
			\  'jpeg'     : '',
			\  'bmp'      : '',
			\  'png'      : '',
			\  'gif'      : '',
			\  'ico'      : '',
			\  'twig'     : '',
			\  'cpp'      : '',
			\  'c++'      : '',
			\  'cxx'      : '',
			\  'cc'       : '',
			\  'cp'       : '',
			\  'c'        : '',
			\  'hs'       : '',
			\  'lhs'      : '',
			\  'lua'      : '',
			\  'java'     : '',
			\  'sh'       : '',
			\  'fish'     : '',
			\  'ml'       : 'λ',
			\  'mli'      : 'λ',
			\  'diff'     : '',
			\  'db'       : '',
			\  'sql'      : '',
			\  'dump'     : '',
			\  'clj'      : '',
			\  'cljc'     : '',
			\  'cljs'     : '',
			\  'edn'      : '',
			\  'scala'    : '',
			\  'go'       : '',
			\  'dart'     : '',
			\  'xul'      : '',
			\  'sln'      : '',
			\  'suo'      : '',
			\  'pl'       : '',
			\  'pm'       : '',
			\  't'        : '',
			\  'rss'      : '',
			\  'f#'       : '',
			\  'fsscript' : '',
			\  'fsx'      : '',
			\  'fs'       : '',
			\  'fsi'      : '',
			\  'rs'       : '',
			\  'rlib'     : '',
			\  'd'        : '',
			\  'erl'      : '',
			\  'hrl'      : '',
			\  'vim'      : '',
			\  'ai'       : '',
			\  'psd'      : '',
			\  'psb'      : '',
			\  'ts'       : '',
			\  'tsx'       : '',
			\  'jl'       : ''
			\}

let s:file_node_exact_matches = {
			\  'exact-match-case-sensitive-1.txt' : 'X1',
			\  'exact-match-case-sensitive-2'     : 'X2',
			\  'gruntfile.coffee'                 : '',
			\  'gruntfile.js'                     : '',
			\  'gruntfile.ls'                     : '',
			\  'gulpfile.coffee'                  : '',
			\  'gulpfile.js'                      : '',
			\  'gulpfile.ls'                      : '',
			\  'dropbox'                          : '',
			\  '.ds_store'                        : '',
			\  '.gitconfig'                       : '',
			\  '.gitignore'                       : '',
			\  '.bashrc'                          : '',
			\  '.bashprofile'                     : '',
			\  'favicon.ico'                      : '',
			\  'license'                          : '',
			\  'node_modules'                     : '',
			\  'react.jsx'                        : '',
			\  'Procfile'                         : '',
			\  '.vimrc'                           : '',
			\}

let s:file_node_pattern_matches = {
			\ '.*jquery.*\.js$'       : '',
			\ '.*angular.*\.js$'      : '',
			\ '.*backbone.*\.js$'     : '',
			\ '.*require.*\.js$'      : '',
			\ '.*materialize.*\.js$'  : '',
			\ '.*materialize.*\.css$' : '',
			\ '.*mootools.*\.js$'     : ''
			\}


function! s:filetypeIcon(path) abort
	let l:file = fnamemodify(a:path, ':t')
	if has_key(s:file_node_exact_matches, l:file)
		return s:file_node_exact_matches[l:file]
	endif
	for [l:k, l:v]  in items(s:file_node_pattern_matches)
		if match(l:file, l:k) != -1
			return l:v
		endif
	endfor
	let l:ext = fnamemodify(l:file, ':e')
	if has_key(g:darkvim_filetype_icons, l:ext)
		return g:darkvim_filetype_icons[l:ext]
	elseif has_key(s:file_node_extensions, l:ext)
		return s:file_node_extensions[l:ext]
	endif
	return ''

endfunction

let s:file['fticon'] = function('s:filetypeIcon')

function! s:write(msg, fname) abort
	let l:flags = filewritable(a:fname) ? 'a' : ''
	call writefile([a:msg], a:fname, l:flags)
endfunction

let s:file['write'] = function('s:write')

function! s:override(msg, fname) abort
	let l:flags = filewritable(a:fname) ? 'b' : ''
	call writefile([a:msg], a:fname, l:flags)
endfunction

let s:file['override'] = function('s:override')

function! s:read(fname) abort
	if filereadable(a:fname)
		return readfile(a:fname, '')
	else
		return ''
	endif
endfunction

let s:file['read'] = function('s:read')

function! s:ls(dir, if_file_only) abort
	let l:items = s:vim_comp.globpath(a:dir, '*')
	if a:if_file_only
		let l:items = filter(l:items, '!isdirectory(v:val)')
	endif
	return map(l:items, "fnamemodify(v:val, ':t')")
endfunction

let s:file['ls'] = function('s:ls')

"
" {
" 'filename' : {
"                 line1 : content,
"                 line2 : content,
"              }
" }
function! s:updatefiles(files) abort
	let l:failed = []
	for l:fname in keys(a:files)
		let l:buffer = readfile(l:fname)
		for l:line in keys(a:files[l:fname])
			let l:buffer[l:line - 1] = a:files[l:fname][l:line]
		endfor
		try
			call writefile(l:buffer, l:fname, 'b')
		catch
			call add(l:failed, l:fname)
		endtry
	endfor
	return l:failed
endfunction


let s:file['updateFiles'] = function('s:updatefiles')

" this function should return a unify path
" 1. the sep is /
" 2. if it is a dir, end with /
" 3. if a:path end with /, then return path also end with /
function! s:unify_path(path, ...) abort
	let l:mod = a:0 > 0 ? a:1 : ':p'
	let l:path = resolve(fnamemodify(a:path, l:mod . ':gs?[\\/]?/?'))
	if isdirectory(l:path) && l:path[-1:] !=# '/'
		return l:path . '/'
	elseif a:path[-1:] ==# '/' && l:path[-1:] !=# '/'
		return l:path . '/'
	else
		return l:path
	endif
endfunction

let s:file['unify_path'] = function('s:unify_path')

function! s:path_to_fname(path) abort
	return substitute(s:unify_path(a:path), '[\\/:;.]', '_', 'g')
endfunction

let s:file['path_to_fname'] = function('s:path_to_fname')

function! darkvim#api#file#get() abort
	return deepcopy(s:file)
endfunction

" vim:set et sw=2:
