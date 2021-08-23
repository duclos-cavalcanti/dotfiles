syntax match regexClosers "[:]"
syntax match regexClosers "[()]"
syntax match regexClosers "[\[\]]"
syntax match regexClosers "[{}]"

syntax match regexOperator "[\*]"

syntax region regexSignature start=+(+ end=+)+ keepend contains=regexClosers,regexOperator
syntax match regexFunctionsTags "\w*[(]" contains=regexSignature

hi regexClosers cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#b48ead guibg=NONE
hi regexOperator cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#d08770 guibg=NONE
hi regexFunctionsTags cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=#8fbcbb guibg=NONE

hi regexSignature cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE

