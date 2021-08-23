function IsSelectedTab(cur_tabnr, selected_tab)
    return a:cur_tabnr == a:selected_tab
endfunction

function IsFirstTab(cur_tabnr)
    return a:cur_tabnr == 1
endfunction

function IsLastTab(cur_tabnr, total_tabs)
    return a:cur_tabnr == a:total_tabs
endfunction

function IsModified(bufnr)
    return getbufvar(a:bufnr, "&mod")
endfunction

function CountNumTabs()
    let l:cnt = 0

    for i in range(tabpagenr('$'))
        let l:cnt += 1
    endfor

    return l:cnt
endfunction

function FormatTabName(sel_bool, mod_bool, bufname, i, num_windows)
    let l:str = ""
    let l:hi = ""

    if a:bufname != ""
        let l:str .= ' ' . a:bufname . ' '
    else
        let l:str .= ' ' . "No Name" . ' '
    endif

    if a:sel_bool && !a:mod_bool        | let l:hi = '%#TabLineSel#' | let g:mod_buffer = 0
    elseif a:sel_bool && a:mod_bool     | let l:hi = '%#TabLineSel#' | let g:mod_buffer = 1
    elseif a:mod_bool                   | let l:hi = '%#TabLine#'    | let g:mod_buffer = 1
    else                                | let l:hi = '%#TabLine#'    | let g:mod_buffer = 0
    endif

    return l:hi . l:str
endfunction

function! TabWorkSpaces()
    let l:str = ""
    let l:num = CountNumTabs()
    for i in range(num)
        let tabnr = i + 1
        let num_windows = tabpagewinnr(tabnr,'$')
        let sel_tab_bool = IsSelectedTab(tabnr, tabpagenr())

        if sel_tab_bool
            let l:hi = '%#TabSelectedSpace#' 
        else
            let l:hi = '%#TabSpace#'
        endif
        let l:str .= l:hi . ' ' . num_windows . ' '
    endfor
    return l:str
endfunction

function! TabLine()
    let s = ''
    let total_tabs = CountNumTabs()

    "let l:s .= '%#EmptyTabLine#'
    "let l:s .=  ReturnSpace(3)

    for i in range(total_tabs)
        let tabnr = i + 1 " range() starts at 0

        let winnr = tabpagewinnr(tabnr)
        let n = tabpagewinnr(tabnr,'$')

        let buflist = tabpagebuflist(tabnr)
        let bufnr = buflist[winnr - 1]
        let bufname = fnamemodify(bufname(bufnr), ':t')

        let sel_tab_bool = IsSelectedTab(tabnr, tabpagenr())
        let next_tab_sel_bool = IsSelectedTab(tabnr + 1, tabpagenr())
        let first_tab_bool = IsFirstTab(tabnr)
        let last_tab_bool = IsLastTab(tabnr, total_tabs)
        let mod_bool = IsModified(bufnr)

        let s .= FormatTabName(sel_tab_bool, mod_bool, bufname, i + 1, n)
    endfor

    let s .= '%#TabLineFill#'
    let s .= "%="

  return s

endfunction

set tabline=%!TabLine()

"TabLineSel - is the current/active tab label.
"TabLine - are the labels which are not currently active.
"TabLineFill - is the remaining of the tabline where there is no labels (background).
