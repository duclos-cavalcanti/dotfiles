let g:mod_buffer = 0

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    let l:hi = "%#LinterStatusLine#"
    if l:counts.total == 0
        return ''
    else
        return l:hi . ' w,e ' . l:all_non_errors . ':' . l:all_errors
    endif
endfunction

let s:last_mode = "" 
function ModeStatus()
    let l:hi = "%#ModeStatusLine#"
    let l:mode = mode()                                                                                                                                                                                 

    if l:mode !=# s:last_mode "Mode change                                                                                                                                                               
        let s:last_mode = l:mode                                                                                                                                                                           
    endif

    if l:mode ==# "n" 
        let l:str = " NORMAL "                                                                                                                                                            

    elseif l:mode ==# "i"
        let l:hi = "%#ModeInsertStatusLine#"
        let l:str = " INSERT "                                                                                                                                                            

    elseif l:mode ==# "c" 
        let l:str = " COMMAND"                                                                                                                                                            

    elseif l:mode ==# "s" 
        let l:str = " SELECT "                                                                                                                                                            

    elseif l:mode ==# "S" 
        let l:str = " SELECT "                                                                                                                                                            

    elseif l:mode ==# "t" 
        let l:str = "TERMINAL"                                                                                                                                                            

    elseif l:mode ==# "R" 
        let l:str = "REPLACE "                                                                                                                                                           

    elseif l:mode ==# "v" 
        let l:hi = "%#ModeVisualStatusLine#"
        let l:str = " VISUAL "                                                                                                                                                            

    elseif l:mode ==# "V" 
        let l:hi = "%#ModeVisualStatusLine#"
        let l:str = " V·LINE "                                                                                                                                                            

    elseif l:mode ==# "\<C-v>"
        let l:hi = "%#ModeVisualStatusLine#"
        let l:str = "V·BLOCK "                                                                                                                                                           
    else
        let l:str = "UNKNOWN "
    endif                                                                                                                                                                                                

    return l:hi . ' ' . l:str
endfunction

function! FilePath()
    let l:hi = '%#BufferStatusLine#'
    let s:middleSL_len += strlen(expand('%:f'))
    return l:hi . '%f'
endfunction

function! FileName()
    let l:hi = '%#FileStatusLine#'
    return l:hi . ' %t ' . '%#EmptyStatusLine#'
endfunction

function! FileEncoding()
    return " " . &fenc==""?&enc:&fenc . " "
endfunction

function! FileType()
    let l:filetype_var = &filetype
    let l:hi = '%#FileTypeStatusLine#'
    return l:hi . l:filetype_var
endfunction

function! ModifiedBuffer()
    " Will be modified in Tabline.vim
    if g:mod_buffer == 1
    let l:hi = '%#EmptyStatusLine#'
        return l:hi . ' + '
    else
        return ''
    endif
endfunction

function! Lines()
    let l:line = line(".")
    let l:str = '%#LineStatusLine#'

    if l:line < 10          | let l:str .= "   " . "%l/%L"
    elseif l:line < 100     | let l:str .= "  "  . "%l/%L"
    elseif l:line < 1000    | let l:str .= " "   . "%l/%L"
    elseif l:line < 10000   | let l:str .= ""    . "%l/%L"
    endif

    return l:str
endfunction

function! Columns()
    let l:col = virtcol(".")
    let l:colMax = virtcol("$") - 1

    let l:str = '%#LineStatusLine#'
    let l:str .= l:col

    return l:str
endfunction

function! LeftStatusLine()
    let l:str = ""

    let l:str .= ModeStatus()
    let l:str .= ExtraSpace()
    let l:str .= GitStatus()
    let l:str .= ExtraSpace()
    let l:str .= ModifiedBuffer()
    let l:str .= '%#EmptyStatusLine#'

    return l:str
endfunction

function! RightStatusLine()
    "Inverts statusline
    let l:str = "%="

    "let l:str .= LinterStatus()
    let l:str .= FileType()
    let l:str .= ExtraSpace()
    let l:str .= Lines()
    let l:str .= ExtraSpace()
    let l:str .= Columns()
    let l:str .= ExtraSpace()

    return l:str
endfunction

function! StatusLine()
    let s = ""
    let s .= LeftStatusLine()
    let s .= RightStatusLine()
    return s
endfunction

"STATUS LINE
set statusline+=%!StatusLine()
