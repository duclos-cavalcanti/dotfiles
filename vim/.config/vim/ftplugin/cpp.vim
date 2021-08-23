if exists("C_PROJECT") " In case inspecting header file of a C project
    setlocal filetype=c
    source ~/.config/vim/ftplugin/c.vim
    source ~/.config/vim/indent/c.vim
endif

if !exists("CPP_PROJECT") " In case we are already within a Cpp project
    let g:CPP_PROJECT=1 
    augroup CPP_PROJECT
        autocmd!
        autocmd BufRead,BufNewFile *.h set filetype=cpp
    augroup END
endif

let termdebugger="gdb"

