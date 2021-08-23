syntax match regexClosers "[:]"
syntax match regexClosers "[()]"
syntax match regexClosers "[\[\]]"
syntax match regexClosers "[{}]"

syntax match regexQuoteString "[\"]"
syntax region regexString start=+"+ end=+"+ keepend contains=regexQuoteString

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
syntax match regexBools "[\!=]"
syntax match regexBools "[==]"

syntax match regexDividers "\;"
syntax match regexDividers "\,"

syntax match regexPointers "&\w*" contains=regexOperator
syntax match regexPointers "\*\w*" contains=regexOperator

syntax match regexAttribSymbols "\."
syntax match regexAttribSymbols "->"
syntax match regexAttrib "\.\w*[^()\[\.\,]" contains=regexAttribSymbols,regexClosers
syntax match regexAttribPtr "->\w*[^\.]" contains=regexAttribSymbols,regexOperator,regexClosers
syntax match regexPreAttrib "\w*\." contains=regexAttrib

syntax match regexCustomTypes "\w*_t "
syntax match regexCustomTypes "\w*_t\* " contains=regexOperator

hi regexClosers cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#b48ead guibg=NONE

hi regexQuoteString cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#bf616a guibg=NONE

hi regexOperator cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#d08770 guibg=NONE

hi regexBools cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#d08770 guibg=NONE

hi regexDividers cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#ebcb8b guibg=NONE

hi regexPreAttrib cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=#ffffff guibg=NONE
hi regexAttribSymbols cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#d08770 guibg=NONE
hi regexAttrib cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE
hi regexAttribPtr cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#88c0d0 guibg=NONE

hi regexCdoc cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#a3be8c guibg=NONE

hi regexPointers cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#bf616a guibg=NONE

hi def link regexCustomTypes Typedef
hi def link regexString String
