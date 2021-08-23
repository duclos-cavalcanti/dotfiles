let g:lsp_enable_diagnostics = v:false

let g:lsc_server_commands = {
    \ 'cpp': {
        \ 'command': 'clangd --background-index',
        \ 'suppress_stderr': v:true
    \},
    \ 'c': {
        \ 'command': 'clangd --background-index',
        \ 'suppress_stderr': v:true
    \},
    \ 'rust': {
        \ 'command': 'rls',
        \ 'suppress_stderr': v:true
    \},
    \ 'python': {
        \ 'command': 'pyls'
    \},
\}

" Complete default mappings
let g:lsc_enable_autocomplete  = v:true
autocmd CompleteDone * silent! pclose

hi lscDiagnosticError cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi lscDiagnosticWarning cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi lscDiagnosticInfo cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi lscDiagnosticHint cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi lscReference cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=#b48ead guibg=NONE

let g:lsc_trace_level = 'off'
