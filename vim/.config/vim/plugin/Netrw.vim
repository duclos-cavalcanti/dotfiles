let g:netrw_menu = 0            " 0 Disables Menu, 1 Enables
let g:netrw_banner = 1          " 0 Disables Banner, 1 Enables
let g:netrw_preview = 1         " 1 Let Preview be Vertical to Netrw, 0 Horizontal
let g:netrw_altv = 1            " Changes from left splitting to right splitting
let g:netrw_alto = 1            " Changes from above splitting to below splitting
let g:netrw_winsize = 50        " Percentage in which 'o' and 'v' opens new files from netrw, also controls size of Sex and Vex
let g:netrw_dirhistmax = 0      " Controls maximum quantity of past history, 0 suppresses it

let g:netrw_liststyle = 0       " 0, thin listing (one file per line), as <ENTER>s go to to that dir
                                " 1, long listing (one file per line with time stamp information and file size)
				                " 2, wide listing (multiple files in columns)
				                " 3, tree style listing

let g:netrw_browse_split = 3    " 1 Horizontal Split
                                " 2 Vertical Split 
                                " 3 New Tab 
                                " 4 Current Window 

let s:netrw_state = 0
function NetrwManager(mode)
    if a:mode == "current" | execute "Ex"
    elseif a:mode == "top_left" | execute "Vex | vertical resize 25"
    elseif a:mode == "top_right"| execute "Vex! | vertical resize 25"
    elseif a:mode == "v_split" | execute "vsplit | Ex"
    elseif a:mode == "h_split" | execute "split | Ex"
    elseif a:mode == "tab" | execute "tabnew | Ex"
    endif
endfunction

