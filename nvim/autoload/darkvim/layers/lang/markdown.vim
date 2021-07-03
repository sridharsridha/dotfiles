
function! darkvim#layers#lang#markdown#plugins() abort
	let l:plugins = []
	" call add(l:plugins, ['plasticboy/vim-markdown', {
	"			\ 'on_ft' : 'markdown',
	"			\ }])
	" call add(l:plugins, ['mzlogin/vim-markdown-toc', {
	"			\ 'on_ft' : 'markdown',
	"			\ }])
	" call add(l:plugins, ['lvht/tagbar-markdown', {
	"			\ 'on_source' : ['tagbar'],
	"			\ }])

	call add(l:plugins, ['iamcco/markdown-preview.nvim', {
				\ 'on_ft' : ['markdown', 'pandoc.markdown', 'rmd'],
				\ 'depends': 'open-browser.vim',
				\ 'build' : 'cd app & yarn install',
				\ }])
	return l:plugins
endfunction

function! darkvim#layers#lang#markdown#config() abort
	" let g:vim_markdown_conceal = 0
	" let g:vim_markdown_conceal_code_blocks = 0
	" let g:vim_markdown_toc_autofit = 1
	" let g:markdown_enable_mappings = 1
	" let g:markdown_enable_insert_mode_leader_mappings = 0
	" let g:markdown_enable_spell_checking = 1
	"
	" let l:remarkrc = s:generate_remarkrc()
	" let g:neoformat_enabled_markdown = ['remark']
	" let g:neoformat_markdown_remark = {
	"			\ 'exe': 'remark',
	"			\ 'args': ['--no-color', '--silent'] + (empty(l:remarkrc) ?  [] : ['-r', l:remarkrc]),
	"			\ 'stdin': 1,
	"			\ }
	"
	" let g:mkdp_browserfunc = 'openbrowser#open'

	" call darkvim#mapping#localleader#reg_lang_mappings_cb('markdown', function('s:mappings'))

	" nnoremap <silent> <plug>(markdown-insert-link) :call <SID>markdown_insert_link(0, 0)<Cr>
	" xnoremap <silent> <plug>(markdown-insert-link) :<C-u> call <SID>markdown_insert_link(1, 0)<Cr>
	" nnoremap <silent> <plug>(markdown-insert-picture) :call <SID>markdown_insert_link(0, 1)<Cr>
	" xnoremap <silent> <plug>(markdown-insert-picture) :<C-u> call <SID>markdown_insert_link(1, 1)<Cr>

	" augroup darkvim_layer_lang_markdown
	" 	autocmd!
	" 	autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
	" augroup END
endfunction

function! s:mappings() abort
	" call darkvim#mapping#localleader#def('nmap', ['p'], 'MarkdownPreview', 'Real-time markdown preview', 1)
	" call darkvim#mapping#localleader#def('nmap', ['k'], '<plug>(markdown-insert-link)', 'add link url', 0, 1)
	" call darkvim#mapping#localleader#def('nmap', ['K'], '<plug>(markdown-insert-picture)', 'add link picture', 0, 1)
endfunction

function! s:generate_remarkrc() abort
	let l:conf = [
				\ 'module.exports = {',
				\ '  settings: {',
				\ ]
	call add(l:conf, '  },')
	call add(l:conf, '  plugins: [')
	" TODO add plugins
	call add(l:conf, "    require('remark-frontmatter'),")
	call add(l:conf, '  ]')
	call add(l:conf, '};')
	let l:f  = tempname() . '.js'
	call writefile(l:conf, l:f)
	return l:f
endfunction

function! s:markdown_insert_link(isVisual, isPicture) abort
	if !empty(@+)
		let l:save_register_unnamed = @"
		let l:save_edge_left = getpos("'<")
		let l:save_edge_right = getpos("'>")
		if !a:isVisual
			execute "normal! viw\<esc>"
		endif
		let l:paste = (col("'>") == col('$') - 1 ? 'p' : 'P')
		normal! gvx
		let @" = '[' . @" . '](' . @+ . ')'
		if a:isPicture
			let @" = '!' . @"
		endif
		execute 'normal! ' . l:paste
		let @" = l:save_register_unnamed
		if a:isVisual
			let l:save_edge_left[2] += 1
			if l:save_edge_left[1] == l:save_edge_right[1]
				let l:save_edge_right[2] += 1
			endif
		endif
		call setpos("'<", l:save_edge_left)
		call setpos("'>", l:save_edge_right)
	endif
endfunction


