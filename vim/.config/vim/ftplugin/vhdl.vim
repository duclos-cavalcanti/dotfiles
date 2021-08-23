" Use :checkpath! to verify if this files were included

function! ParseInclude(fname)
    return get(split(a:fname,'\.'),1)
endfunction

let g:vhdl_indent_genportmap = 1
let g:vhdl_indent_rhsassign = 1

setlocal textwidth=75

setlocal comments=n:-
setlocal formatoptions=cron

" the paths are relative to current directoy ($PWD)
setlocal path =*/*    " Tradicional file tree
setlocal path =*/*/*  " MyHDL file tree

" XILINX_LIB_DIR is defined at $HOME/.zshenv
if isdirectory($XILINX_LIB_DIR)
    setlocal path+=expand($XILINX_LIB_DIR).'/vhdl/ieee_2008/*'
    setlocal path+=expand($XILINX_LIB_DIR).'/vhdl/unisims/*/*'
    setlocal path+=expand($XILINX_LIB_DIR).'/vhdl/unimacro'
endif

setlocal suffixesadd+=.vhd  " jump to file (gf)
setlocal suffixesadd+=.vhdl " jump to file (gf)

setlocal include=use
setlocal includeexpr=ParseInclude(v:fname)

setlocal complete=
setlocal complete+=. " Current buffer
setlocal complete+=i " Included files
setlocal complete+=w " Others windows
setlocal complete+=t " Tags

setlocal errorformat=
" Xilinx Error formats
setlocal errorformat+=%tRROR:\ [VRFC\ %*[0123456789^]-%n]\ %m[%f:%l]
setlocal errorformat+=%tRROR:\ [XSIM\ %*[0123456789^]-%n]\ %m[%f:%l]
" GHDL Error formats
setlocal errorformat+=%f:%l:%c:%trror:\ %m
setlocal errorformat+=\.\.\/\.\.\/%f:%l:%c:\ %m
