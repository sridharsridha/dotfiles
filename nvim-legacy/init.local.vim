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

function AGidFull()
   silent execute "AGid " . expand("<cword>")
endfunc

function AGidDef()
   silent execute "AGid -D " . expand("<cword>")
endfunc

function AGidPySym()
   silent execute "AGid --compact -t p " . expand("<cword>")
endfunc

function LocalMappings()
   let g:which_key_map.s = {
         \ 'name' : '+agid' ,
         \ 'f' : ['AGidFull()', 'full-search'],
         \ 'd' : ['AGidDef()', 'definition'],
         \ 'p' : ['AGidPySym()', 'python-symbols'],
         \ 'v' : [':silent AGidVerbose -c'     , 'grep-verbose'],
         \ }
endfunc

