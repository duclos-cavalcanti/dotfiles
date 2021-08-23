let s:quickfix_state = 0
function ToggleQuickFix()
    if !s:quickfix_state
        execute ":copen"
        let s:quickfix_state = 1
    else
        execute ":cclose"
        let s:quickfix_state = 0
    endif
endfunction
