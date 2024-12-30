" Do not load a.vim if is has already been loaded.
if exists('loaded_alternateFile')
	finish
endif
if (v:progname ==# 'ex')
	finish
endif
let g:loaded_alternateFile = 1

let g:alternateExtensionsDict = {}
let s:maxDotsInExtension = 1

" Setup default search path, unless the user has specified
" a path in their [._]vimrc.
if (!exists('g:alternateSearchPath'))
	let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc'
endif

" If this variable is true then a.vim will not alternate to a file/buffer which
" does not exist. E.g while editing a.c and the :A will not swtich to a.h
" unless it exists.
if (!exists('g:alternateNoDefaultAlternate'))
	" by default a.vim will alternate to a file which does not exist
	let g:alternateNoDefaultAlternate = 0
endif

" If this variable is true then a.vim will convert the alternate filename to a
" filename relative to the current working directory.
if (!exists('g:alternateRelativeFiles'))
	" by default a.vim will not convert the filename to one relative to the
	" current working directory
	let g:alternateRelativeFiles = 0
endif

function! darkvim#plugins#a#add_ext_map(extension, alternates) abort
	let g:alternateExtensionsDict[a:extension] = a:alternates
	let l:dotsNumber = strlen(substitute(a:extension, '[^.]', '', 'g'))
	if s:maxDotsInExtension < l:dotsNumber
		let s:maxDotsInExtension = l:dotsNumber
	endif
endfunction

function! darkvim#plugins#a#open(splitWindow, ...) abort
	let l:extension   = DetermineExtension(expand('%:p'))
	let l:baseName    = substitute(expand('%:t'), '\.' . l:extension . '$', '', '')
	let l:currentPath = expand('%:p:h')

	if (a:0 !=# 0)
		let l:newFullname = l:currentPath . '/' .  l:baseName . '.' . a:1
		call <SID>FindOrCreateBuffer(l:newFullname, a:splitWindow, 0)
	else
		let l:allfiles = ''
		if (l:extension !=# '')
			let l:allfiles1 = EnumerateFilesByExtension(l:currentPath, l:baseName, l:extension)
			let l:allfiles2 = EnumerateFilesByExtensionInPath(l:baseName, l:extension, g:alternateSearchPath, l:currentPath)

			if (l:allfiles1 !=# '')
				if (l:allfiles2 !=# '')
					let l:allfiles = l:allfiles1 . ',' . l:allfiles2
				else
					let l:allfiles = l:allfiles1
				endif
			else
				let l:allfiles = l:allfiles2
			endif
		endif

		if (l:allfiles !=# '')
			let l:bestFile = ''
			let l:bestScore = 0
			let l:score = 0
			let l:n = 1

			let l:onefile = <SID>GetNthItemFromList(l:allfiles, l:n)
			let l:bestFile = l:onefile
			while (l:onefile !=# '' && l:score < 2)
				let l:score = <SID>BufferOrFileExists(l:onefile)
				if (l:score > l:bestScore)
					let l:bestScore = l:score
					let l:bestFile = l:onefile
				endif
				let l:n = l:n + 1
				let l:onefile = <SID>GetNthItemFromList(l:allfiles, l:n)
			endwhile

			if (l:bestScore ==# 0 && g:alternateNoDefaultAlternate ==# 1)
				echo 'No existing alternate available'
			else
				call <SID>FindOrCreateBuffer(l:bestFile, a:splitWindow, 1)
				let b:AlternateAllFiles = l:allfiles
			endif
		else
			echo 'No alternate file/buffer available'
		endif
	endif
endfunction

function! darkvim#plugins#a#open_uc(splitWindow,...) abort
	let l:cursorFile = (a:0 > 0) ? a:1 : expand('<cfile>')
	let l:currentPath = expand('%:p:h')
	let l:openCount = 1

	let l:fileName = <SID>FindFileInSearchPathEx(l:cursorFile, g:alternateSearchPath, l:currentPath, l:openCount)
	if (l:fileName !=# '')
		call <SID>FindOrCreateBuffer(l:fileName, a:splitWindow, 1)
		let b:openCount = l:openCount
		let b:cursorFile = l:cursorFile
		let b:currentPath = l:currentPath
	else
		echo 'Cant find file'
	endif
endfunction

function! darkvim#plugins#a#open_next(bang) abort
	let l:cursorFile = ''
	if (exists('b:cursorFile'))
		let l:cursorFile = b:cursorFile
	endif

	let l:currentPath = ''
	if (exists('b:currentPath'))
		let l:currentPath = b:currentPath
	endif

	let l:openCount = 0
	if (exists('b:openCount'))
		let l:openCount = b:openCount + 1
	endif

	if (l:cursorFile !=# ''  && l:currentPath !=# ''  && l:openCount !=# 0)
		let l:fileName = <SID>FindFileInSearchPathEx(l:cursorFile, g:alternateSearchPath, l:currentPath, l:openCount)
		if (l:fileName !=# '')
			call <SID>FindOrCreateBuffer(l:fileName, 'n'.a:bang, 0)
			let b:openCount = l:openCount
			let b:cursorFile = l:cursorFile
			let b:currentPath = l:currentPath
		else
			let l:fileName = <SID>FindFileInSearchPathEx(l:cursorFile, g:alternateSearchPath, l:currentPath, 1)
			if (l:fileName !=# '')
				call <SID>FindOrCreateBuffer(l:fileName, 'n'.a:bang, 0)
				let b:openCount = 1
				let b:cursorFile = l:cursorFile
				let b:currentPath = l:currentPath
			else
				echo 'Cant find next file'
			endif
		endif
	endif
endfunction

function! darkvim#plugins#a#next(bang) abort
	if (exists('b:AlternateAllFiles'))
		let l:currentFile = expand('%')
		let l:n = 1
		let l:onefile = <SID>GetNthItemFromList(b:AlternateAllFiles, l:n)
		while (l:onefile !=# '' && !<SID>EqualFilePaths(fnamemodify(l:onefile,':p'), fnamemodify(l:currentFile,':p')))
			let l:n = l:n + 1
			let l:onefile = <SID>GetNthItemFromList(b:AlternateAllFiles, l:n)
		endwhile

		if (l:onefile !=# '')
			let l:stop = l:n
			let l:n = l:n + 1
			let l:foundAlternate = 0
			let l:nextAlternate = ''
			while (l:n !=# l:stop)
				let l:nextAlternate = <SID>GetNthItemFromList(b:AlternateAllFiles, l:n)
				if (l:nextAlternate ==# '')
					let l:n = 1
					continue
				endif
				let l:n = l:n + 1
				if (<SID>EqualFilePaths(fnamemodify(l:nextAlternate, ':p'), fnamemodify(l:currentFile, ':p')))
					continue
				endif
				if (filereadable(l:nextAlternate))
					if (has('unix') && $WINDIR !=# '' && fnamemodify(l:nextAlternate, ':p') ==? fnamemodify(l:currentFile, ':p'))
						continue
					endif
					let l:foundAlternate = 1
					break
				endif
			endwhile
			if (l:foundAlternate ==# 1)
				let s:AlternateAllFiles = b:AlternateAllFiles
				call <SID>FindOrCreateBuffer(l:nextAlternate, 'n'.a:bang, 0)
				let b:AlternateAllFiles = s:AlternateAllFiles
			else
				echo 'Only this alternate file exists'
			endif
		else
			echo 'Could not find current file in alternates list'
		endif
	else
		echo 'No other alternate files exist'
	endif
endfunction

function! <SID>BufferOrFileExists(fileName) abort
	let l:result = 0

	let l:lastBuffer = bufnr('$')
	let l:i = 1
	while l:i <= l:lastBuffer
		if <SID>EqualFilePaths(expand('#'.l:i.':p'), a:fileName)
			let l:result = 2
			break
		endif
		let l:i = l:i + 1
	endwhile

	if (!l:result)
		let l:bufName = fnamemodify(a:fileName,':t')
		let l:memBufName = bufname(l:bufName)
		if (l:memBufName !=# '')
			let l:memBufBasename = fnamemodify(l:memBufName, ':t')
			if (l:bufName ==# l:memBufBasename)
				let l:result = 2
			endif
		endif

		if (!l:result)
			let l:result  = bufexists(l:bufName) || bufexists(a:fileName) || filereadable(a:fileName)
		endif
	endif

	if (!l:result)
		let l:result = filereadable(a:fileName)
	endif
	return l:result
endfunction


function! <SID>GetNthItemFromList(list, n) abort
	let l:itemStart = 0
	let l:itemEnd = -1
	let l:pos = 0
	let l:item = ''
	let l:i = 0
	while (l:i !=# a:n)
		let l:itemStart = l:itemEnd + 1
		let l:itemEnd = match(a:list, ',', l:itemStart)
		let l:i = l:i + 1
		if (l:itemEnd ==# -1)
			if (l:i ==# a:n)
				let l:itemEnd = strlen(a:list)
			endif
			break
		endif
	endwhile
	if (l:itemEnd !=# -1)
		let l:item = strpart(a:list, l:itemStart, l:itemEnd - l:itemStart)
	endif
	return l:item
endfunction

function! <SID>ExpandAlternatePath(pathSpec, sfPath) abort
	let l:prfx = strpart(a:pathSpec, 0, 4)
	if (l:prfx ==# 'wdr:' || l:prfx ==# 'abs:')
		let l:path = strpart(a:pathSpec, 4)
	elseif (l:prfx ==# 'reg:')
		let l:re = strpart(a:pathSpec, 4)
		let l:sep = strpart(l:re, 0, 1)
		let l:patend = match(l:re, l:sep, 1)
		let l:pat = strpart(l:re, 1, l:patend - 1)
		let l:subend = match(l:re, l:sep, l:patend + 1)
		let l:sub = strpart(l:re, l:patend+1, l:subend - l:patend - 1)
		let l:flag = strpart(l:re, strlen(l:re) - 2)
		if (l:flag ==# l:sep)
			let l:flag = ''
		endif
		let l:path = substitute(a:sfPath, l:pat, l:sub, l:flag)
		"call confirm('PAT: [' . pat . '] SUB: [' . sub . ']')
		"call confirm(a:sfPath . ' => ' . path)
	else
		let l:path = a:pathSpec
		if (l:prfx ==# 'sfr:')
			let l:path = strpart(l:path, 4)
		endif
		let l:path = a:sfPath . '/' . l:path
	endif
	return l:path
endfunction

function! <SID>FindFileInSearchPath(fileName, pathList, relPathBase) abort
	let l:filepath = ''
	let l:m = 1
	let l:pathListLen = strlen(a:pathList)
	if (l:pathListLen > 0)
		while (1)
			let l:pathSpec = <SID>GetNthItemFromList(a:pathList, l:m)
			if (l:pathSpec !=# '')
				let l:path = <SID>ExpandAlternatePath(l:pathSpec, a:relPathBase)
				let l:fullname = l:path . '/' . a:fileName
				let l:foundMatch = <SID>BufferOrFileExists(l:fullname)
				if (l:foundMatch)
					let l:filepath = l:fullname
					break
				endif
			else
				break
			endif
			let l:m = l:m + 1
		endwhile
	endif
	return l:filepath
endfunction

function! <SID>FindFileInSearchPathEx(fileName, pathList, relPathBase, count) abort
	let l:filepath = ''
	let l:m = 1
	let l:spath = ''
	let l:pathListLen = strlen(a:pathList)
	if (l:pathListLen > 0)
		while (1)
			let l:pathSpec = <SID>GetNthItemFromList(a:pathList, l:m)
			if (l:pathSpec !=# '')
				let l:path = <SID>ExpandAlternatePath(l:pathSpec, a:relPathBase)
				if (l:spath !=# '')
					let l:spath = l:spath . ','
				endif
				let l:spath = l:spath . l:path
			else
				break
			endif
			let l:m = l:m + 1
		endwhile
	endif

	if (&path !=# '')
		if (l:spath !=# '')
			let l:spath = l:spath . ','
		endif
		let l:spath = l:spath . &path
	endif

	let l:filepath = findfile(a:fileName, l:spath, a:count)
	return l:filepath
endfunction

function! EnumerateFilesByExtension(path, baseName, extension) abort
	let l:enumeration = ''
	let l:extSpec = ''
	let v:errmsg = ''
	silent! echo g:alternateExtensions_{a:extension}
	if (v:errmsg ==# '')
		let l:extSpec = g:alternateExtensions_{a:extension}
	endif
	if (l:extSpec ==# '')
		if (has_key(g:alternateExtensionsDict, a:extension))
			let l:extSpec = g:alternateExtensionsDict[a:extension]
		endif
	endif
	if (l:extSpec !=# '')
		let l:n = 1
		let l:done = 0
		while (!l:done)
			let l:ext = <SID>GetNthItemFromList(l:extSpec, l:n)
			if (l:ext !=# '')
				if (a:path !=# '')
					let l:newFilename = a:path . '/' . a:baseName . '.' . l:ext
				else
					let l:newFilename =  a:baseName . '.' . l:ext
				endif
				if (l:enumeration ==# '')
					let l:enumeration = l:newFilename
				else
					let l:enumeration = l:enumeration . ',' . l:newFilename
				endif
			else
				let l:done = 1
			endif
			let l:n = l:n + 1
		endwhile
	endif
	return l:enumeration
endfunction

function! EnumerateFilesByExtensionInPath(baseName, extension, pathList, relPathBase) abort
	let l:enumeration = ''
	let l:filepath = ''
	let l:m = 1
	let l:pathListLen = strlen(a:pathList)
	if (l:pathListLen > 0)
		while (1)
			let l:pathSpec = <SID>GetNthItemFromList(a:pathList, l:m)
			if (l:pathSpec !=# '')
				let l:path = <SID>ExpandAlternatePath(l:pathSpec, a:relPathBase)
				let l:pe = EnumerateFilesByExtension(l:path, a:baseName, a:extension)
				if (l:enumeration ==# '')
					let l:enumeration = l:pe
				else
					let l:enumeration = l:enumeration . ',' . l:pe
				endif
			else
				break
			endif
			let l:m = l:m + 1
		endwhile
	endif
	return l:enumeration
endfunction

function! DetermineExtension(path) abort
	let l:mods = ':t'
	let l:i = 0
	while l:i <= s:maxDotsInExtension
		let l:mods = l:mods . ':e'
		let l:extension = fnamemodify(a:path, l:mods)
		if (has_key(g:alternateExtensionsDict, l:extension))
			return l:extension
		endif
		let v:errmsg = ''
		silent! echo g:alternateExtensions_{extension}
		if (v:errmsg ==# '')
			return l:extension
		endif
		let l:i = l:i + 1
	endwhile
	return ''
endfunction

function! <SID>FindOrCreateBuffer(fileName, doSplit, findSimilar) abort
	" Check to see if the buffer is already open before re-opening it.
	let l:FILENAME = escape(a:fileName, ' ')
	let l:bufNr = -1
	let l:lastBuffer = bufnr('$')
	let l:i = 1
	if (a:findSimilar)
		while l:i <= l:lastBuffer
			if <SID>EqualFilePaths(expand('#'.l:i.':p'), a:fileName)
				let l:bufNr = l:i
				break
			endif
			let l:i = l:i + 1
		endwhile

		if (l:bufNr ==# -1)
			let l:bufName = bufname(a:fileName)
			let l:bufFilename = fnamemodify(a:fileName,':t')

			if (l:bufName ==# '')
				let l:bufName = bufname(l:bufFilename)
			endif

			if (l:bufName !=# '')
				let l:tail = fnamemodify(l:bufName, ':t')
				if (l:tail !=# l:bufFilename)
					let l:bufName = ''
				endif
			endif
			if (l:bufName !=# '')
				let l:bufNr = bufnr(l:bufName)
				let l:FILENAME = l:bufName
			endif
		endif
	endif

	if (g:alternateRelativeFiles ==# 1)
		let l:FILENAME = fnamemodify(l:FILENAME, ':p:.')
	endif

	let l:splitType = a:doSplit[0]
	let l:bang = a:doSplit[1]
	if (l:bufNr ==# -1)
		" Buffer did not exist....create it
		let v:errmsg=''
		if (l:splitType ==# 'h')
			silent! execute ':split'.l:bang.' ' . l:FILENAME
		elseif (l:splitType ==# 'v')
			silent! execute ':vsplit'.l:bang.' ' . l:FILENAME
		elseif (l:splitType ==# 't')
			silent! execute ':tab split'.l:bang.' ' . l:FILENAME
		else
			silent! execute ':e'.l:bang.' ' . l:FILENAME
		endif
		if (v:errmsg !=# '')
			echo v:errmsg
		endif
	else

		" Find the correct tab corresponding to the existing buffer
		let l:tabNr = -1
		" iterate tab pages
		for l:i in range(tabpagenr('$'))
			" get the list of buffers in the tab
			let l:tabList =  tabpagebuflist(l:i + 1)
			let l:idx = 0
			" iterate each buffer in the list
			while l:idx < len(l:tabList)
				" if it matches the buffer we are looking for...
				if (l:tabList[l:idx] ==# l:bufNr)
					" ... save the number
					let l:tabNr = l:i + 1
					break
				endif
				let l:idx = l:idx + 1
			endwhile
			if (l:tabNr !=# -1)
				break
			endif
		endfor
		" switch the the tab containing the buffer
		if (l:tabNr !=# -1)
			execute 'tabn '.l:tabNr
		endif

		" Buffer was already open......check to see if it is in a window
		let l:bufWindow = bufwinnr(l:bufNr)
		if (l:bufWindow ==# -1)
			" Buffer was not in a window so open one
			let v:errmsg=''
			if (l:splitType ==# 'h')
				silent! execute ':sbuffer'.l:bang.' ' . l:FILENAME
			elseif (l:splitType ==# 'v')
				silent! execute ':vert sbuffer ' . l:FILENAME
			elseif (l:splitType ==# 't')
				silent! execute ':tab sbuffer ' . l:FILENAME
			else
				silent! execute ':buffer'.l:bang.' ' . l:FILENAME
			endif
			if (v:errmsg !=# '')
				echo v:errmsg
			endif
		else
			" Buffer is already in a window so switch to the window
			execute l:bufWindow.'wincmd w'
			if (l:bufWindow !=# winnr())
				" something wierd happened...open the buffer
				let v:errmsg=''
				if (l:splitType ==# 'h')
					silent! execute ':split'.l:bang.' ' . l:FILENAME
				elseif (l:splitType ==# 'v')
					silent! execute ':vsplit'.l:bang.' ' . l:FILENAME
				elseif (l:splitType ==# 't')
					silent! execute ':tab split'.l:bang.' ' . l:FILENAME
				else
					silent! execute ':e'.l:bang.' ' . l:FILENAME
				endif
				if (v:errmsg !=# '')
					echo v:errmsg
				endif
			endif
		endif
	endif
endfunction

function! <SID>EqualFilePaths(path1, path2) abort
	if has('win16') || has('win32') || has('win64') || has('win95')
		return substitute(a:path1, '\/', '\\', 'g') ==? substitute(a:path2, '\/', '\\', 'g')
	else
		return a:path1 ==# a:path2
	endif
endfunction

" Add all the default extensions
" Mappings for C and C++
call darkvim#plugins#a#add_ext_map('h','c,cpp,cxx,cc,CC')
call darkvim#plugins#a#add_ext_map('H','C,CPP,CXX,CC')
call darkvim#plugins#a#add_ext_map('hpp','cpp,c')
call darkvim#plugins#a#add_ext_map('HPP','CPP,C')
call darkvim#plugins#a#add_ext_map('c','h')
call darkvim#plugins#a#add_ext_map('C','H')
call darkvim#plugins#a#add_ext_map('cpp','h,hpp')
call darkvim#plugins#a#add_ext_map('CPP','H,HPP')
call darkvim#plugins#a#add_ext_map('cc','h')
call darkvim#plugins#a#add_ext_map('CC','H,h')
call darkvim#plugins#a#add_ext_map('cxx','h')
call darkvim#plugins#a#add_ext_map('CXX','H')
call darkvim#plugins#a#add_ext_map('itin','tin')
call darkvim#plugins#a#add_ext_map('tin','tac')
call darkvim#plugins#a#add_ext_map('tac','tin,itin')

" Mappings for PSL7
call darkvim#plugins#a#add_ext_map('psl','ph')
call darkvim#plugins#a#add_ext_map('ph','psl')

" Mappings for ADA
call darkvim#plugins#a#add_ext_map('adb','ads')
call darkvim#plugins#a#add_ext_map('ads','adb')

" Mappings for lex and yacc files
call darkvim#plugins#a#add_ext_map('l','y,yacc,ypp')
call darkvim#plugins#a#add_ext_map('lex','yacc,y,ypp')
call darkvim#plugins#a#add_ext_map('lpp','ypp,y,yacc')
call darkvim#plugins#a#add_ext_map('y','l,lex,lpp')
call darkvim#plugins#a#add_ext_map('yacc','lex,l,lpp')
call darkvim#plugins#a#add_ext_map('ypp','lpp,l,lex')

" Mappings for OCaml
call darkvim#plugins#a#add_ext_map('ml','mli')
call darkvim#plugins#a#add_ext_map('mli','ml')

" ASP stuff
call darkvim#plugins#a#add_ext_map('aspx.cs', 'aspx')
call darkvim#plugins#a#add_ext_map('aspx.vb', 'aspx')
call darkvim#plugins#a#add_ext_map('aspx', 'aspx.cs,aspx.vb')

