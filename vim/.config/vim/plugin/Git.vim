let g:Gbranch=""

function! FetchGitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! GitStatus()
    let l:branchname = g:Gbranch
    let l:hi = "%#GitStatusLine#"

    if strlen(l:branchname) > 0  
        return l:hi .  ' ' . l:branchname . ' ' . '%#EmptyStatusLine#'
    else 
        return ''
    endif
endfunction

augroup ARRIVEBUFFER
    autocmd!
    autocmd BufNewFile,BufRead * let g:Gbranch=FetchGitBranch()
augroup END

