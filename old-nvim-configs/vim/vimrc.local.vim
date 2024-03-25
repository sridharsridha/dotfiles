" Include the system settings
:if filereadable('/etc/vimrc')
   source /etc/vimrc
:endif

" Include Arista-specific settings
:if filereadable('/usr/share/vim/vimfiles/arista.vim')
   source /usr/share/vim/vimfiles/arista.vim
:endif

let g:AGid_OpenQuickfixWindowAtTop = 0
let g:AGid_FoldQuickfixWindow = 0
let g:AGid_Jump_To_Match = 0

nnoremap <expr> <Space>sd ':AGid -D '.expand('<cword>').'<cr>'.'<cr>'
nnoremap <expr> <Space>ss ':AGid '.expand('<cword>').'<cr>'.'<cr>'
nnoremap <expr> <Space>sp ':AGid -t p '.expand('<cword>').'<cr>'.'<cr>'

set background=dark
