let g:bullets_mapping_leader = '<space>xb'
" Set <space>xb to the leader before all default mappings:
" Example: renumbering becomes `<space>xbgN` instead of just `gN`
"
" Insert new bullet in INSERT mode: <cr> (Return key)
" Same as in case you want to unmap in INSERT mode (compatibility depends on your terminal emulator): <C-cr>
" Insert new bullet in NORMAL mode: o
" Renumber current visual selection: gN
" Renumber entire bullet list containing the cursor in NORMAL mode: gN
" Toggle a checkbox in NORMAL mode: <leader>x
" Demote a bullet (indent it, decrease bullet level, and make it a child of the previous bullet):
" NORMAL mode: >>
" INSERT mode: <C-t>
" VISUAL mode: >
" Promote a bullet (unindent it and increase the bullet level):
" NORMAL mode: <<
" INSERT mode: <C-d>
" VISUAL mode: >
