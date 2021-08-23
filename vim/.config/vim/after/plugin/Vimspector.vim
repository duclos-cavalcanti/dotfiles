
" Default Mappings option
"let g:vimspector_enable_mappings = 'HUMAN'
"

function! s:CopyVimspector(ft)
    exe '!cp ~/.config/vim/spector/' . a:ft . '/vimspector.json' . ' ./.vimspector.json'
endfunction

function! s:DeleteVimspector()
    exe '!rm ./.vimspector.json'
endfunction

command! DeleteVimspector call s:DeleteVimspector()
command! -nargs=1 CopyVimspector call s:CopyVimspector(<f-args>)

sign define vimspectorBP text=o          texthl=WarningMsg
sign define vimspectorBPCond text=o?     texthl=WarningMsg
sign define vimspectorBPDisabled text=o! texthl=LineNr
sign define vimspectorPC text=\ >        texthl=MatchParen
sign define vimspectorPCBP text=o>       texthl=MatchParen

let g:ycm_semantic_triggers = { 'VimspectorPrompt': [ '.', '->', ':', '<' ] }
