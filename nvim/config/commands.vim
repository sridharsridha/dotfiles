command! -nargs=? -bang A call darkvim#plugins#a#open("n<bang>", <f-args>)
command! -nargs=? -bang AS call darkvim#plugins#a#open("h<bang>", <f-args>)
command! -nargs=? -bang AV call darkvim#plugins#a#open("v<bang>", <f-args>)
command! -nargs=? -bang AN call darkvim#plugins#a#next("<bang>")
