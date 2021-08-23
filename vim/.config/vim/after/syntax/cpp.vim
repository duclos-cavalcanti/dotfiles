syntax keyword cppStd std
syntax keyword cppBool true
syntax keyword cppBool false

syntax match regexClosers "[:]"
syntax match regexClosers "[()]"
syntax match regexClosers "[\[\]]"
syntax match regexClosers "[{}]"

syntax match regexOperator "[-]"
syntax match regexOperator "[+]"
syntax match regexOperator "[\*]"
syntax match regexOperator "[/][^/\*]"
syntax match regexOperator "[=]"
syntax match regexOperator "[<>]"
syntax match regexOperator "[>]" "xor
syntax match regexOperator "[&]" "and
syntax match regexOperator "[|]" "or

syntax match regexBools "[&|][&|]"
syntax match regexBools "[\!]"
syntax match regexBools "\!="
syntax match regexBools "=="

syntax match regexPointers "&\w*" contains=regexOperator
syntax match regexPointers "\*\w*" contains=regexOperator

syntax match regexTemplate "<\w*>"
syntax match regexTemplate "< \w* >"
syntax match regexTemplate "<\w* \w*>"
syntax match regexTemplate "<\w* \w* \w*>"

syntax match regexDividers "\;"
syntax match regexDividers "\,"

syntax match regexIO "[<>][<>]"

syntax match regexAttribSymbols "\."
syntax match regexAttribSymbols "->"
syntax match regexAttrib "\.\w*[^()\[\.\,]" contains=regexAttribSymbols,regexClosers
syntax match regexAttribPtr "->\w*[^\.]" contains=regexAttribSymbols,regexOperator,regexClosers
syntax match regexPreAttrib "\w*\." contains=regexAttrib

syntax match regexCustomTypes "\w*_t "
syntax match regexCustomTypes "\w*_t\* " contains=regexOperator

"syntax match regexSystemC "\s*sc_\w* " contains=regexTemplate

syntax region regionQuote start=+'+ end=+'+ keepend

hi cppStd cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#588383 guibg=NONE
hi cppBool cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE

hi regexClosers cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#b48ead guibg=NONE

hi regexOperator cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#d08770 guibg=NONE

hi regexIO cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=#b48ead guibg=NONE

hi regexDividers cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE

hi regexBools cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#d08770 guibg=NONE
hi regexPointers cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#bf616a guibg=NONE

hi regexPreAttrib cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=#ffffff guibg=NONE
hi regexAttribSymbols cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#d08770 guibg=NONE
hi regexAttrib cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE
hi regexAttribPtr cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE

hi regexTemplate cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE

hi regexSystemC cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE

hi! link regionQuote String


