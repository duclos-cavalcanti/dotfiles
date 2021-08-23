let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1

let g:ale_fix_on_save = 0

let g:ale_c_parse_compile_commands = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8', 'trim_whitespace', 'remove_trailing_lines'],
\   'c': ['autopep8', 'trim_whitespace', 'remove_trailing_lines'],
\   'cc': ['clang-format','trim_whitespace', 'remove_trailing_lines'],
\   'cpp': ['clang-format','trim_whitespace', 'remove_trailing_lines'],
\}

"This causes to only use linters specified within the dict below.
" let g:ale_linters_explicit = 1 
let g:ale_linters = {
\ 'python': ['pylint'],
\}

hi clear ALESignColumnWithErrors
hi clear ALESignColumnWithoutErrors

hi ALEError cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi ALEWarning cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE

let g:ale_set_signs = 1

hi ALEErrorSign cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#bf616a guibg=NONE
hi ALEWarningSign cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#ebcb8b guibg=NONE

let g:ale_sign_error = ' -'
let g:ale_sign_warning = ' ~'
"
let g:ale_echo_msg_format = '%linter% - %severity% : %s'
