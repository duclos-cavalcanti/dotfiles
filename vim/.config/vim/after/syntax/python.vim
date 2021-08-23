syntax keyword pythSelf self

syntax match regexComma "\,"
syntax match regexClosers "[:]"
syntax match regexClosers "[()]"
syntax match regexClosers "[\[\]]"
syntax match regexClosers "[{}]"

syntax match regexQuoteString "[\"]"
syntax match regexClosersString "[{}]"

syntax match regexOperator "[-]"
syntax match regexOperator "[+]"
syntax match regexOperator "[=]"
syntax match regexOperator "[\/]"
syntax match regexOperator "[<>]"

syntax match regexFunction "\w*[(]" contains=regexClosers
syntax match regexMethod "\.\w*[^()\[\.\,]"
syntax match regexPreMethod "\w*\." contains=regexMethod

syntax region regexString start=+"+ end=+"+ keepend contains=regexClosersString,regexQuoteString

"Matches words in between the parentheses, however uses the regexCloses
"to color the characters chosen on skip.
" syntax region regexArguments matchgroup=regexClosers start=+(+ skip=+()+ end=+)+ contains=regexComma,regexMethod,regexClosers,String keepend
 
hi regexOperator cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#d08770 guibg=NONE
hi regexClosers cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#b48ead guibg=NONE

hi regexPreMethod cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=#ffffff guibg=NONE
hi regexMethod cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE
hi regexFunction cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE

hi regexArguments cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=#ffffff guibg=NONE
hi regexComma cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#ffffff guibg=NONE

hi regexQuoteString cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#bf616a guibg=NONE

"Overwriting pythonFunction highlight group that controls highlighting
"of function names.
hi pythonFunction cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE
hi pythSelf cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#bf616a guibg=NONE

hi def link regexString String
hi def link regexClosersString regexClosers

