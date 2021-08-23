setlocal syntax=markdown
setlocal wrap
setlocal spell spelllang=en_us
setlocal textwidth=90

nnoremap <buffer> <leader>bold i****<ESC>hi
nnoremap <buffer> <leader>fig i<SPACE>![IMG](<path_to_img>)<ESC>FP

"nnoremap <silent> <CR> :!cat % \| mdless && clear<CR>
