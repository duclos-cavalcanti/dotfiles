let s:TerminalON = 0
function TerminalManager(mode)
    let l:bufnr = bufnr('%')
    let l:bufname = bufname()

	let buflist = []
	call extend(buflist, tabpagebuflist(tabpagenr()))

    if !s:TerminalON
        if a:mode == "pane" | execute "split | term ++curwin ++kill=hup ++rows=15"
        elseif a:mode == "v_current" | execute "vertical term ++kill=hup"
        elseif a:mode == "h_current" | execute "split | term ++curwin ++kill=hup"
        elseif a:mode == "current" | execute "term ++curwin ++kill=hup"
        elseif a:mode == "tab" | execute "tab term ++kill=hup"
        endif

        let s:TerminalON = 1
    else
        if a:mode == "pane" | execute "split | resize 15 | buffer bash"
        elseif a:mode == "v_current" | execute "vsplit | buffer bash"
        elseif a:mode == "h_current" | execute "split | buffer bash"
        elseif a:mode == "current" | execute "buffer bash"
        elseif a:mode == "tab" | execute "tabnew | buffer bash"
        endif
    endif
endfunction
