if exists ("b:current_syntax")
    finish
endif

let b:current_syntax = "csv"

syntax match regexComma "\,"
syntax match regexNumber "[0-9]"

hi regexComma cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#d400bc guibg=NONE
hi regexNumber cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#00bcd4 guibg=NONE

