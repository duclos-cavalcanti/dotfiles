" SearchCheck() searches for whether or not TodoCheck was called on a
" checked or unchecked task. 
"
" We need to call search() twice with and without 
" the 'b' tag because search() only allows you to search either forward or backwards.
"
" search() returns 0 if it the pattern was not found
function <SID>SearchCheck()
  return (search('\[\]', 'nc', line('.')) || search('\[\]', 'nbc', line('.')))
endfunction

" Edit markdown lists
" Add and remove bullets with ease
" If we are already checked then we uncheck
nnoremap <expr> <silent> <buffer> <Plug>TodoChecknormal <SID>SearchCheck() ? ':.s/\[\]/\[x\]<Enter>' : ':.s/\[x\]/\[\]<Enter>' 
nnoremap <silent> <buffer> <Plug>TodoAddnormal i-[] 

inoremap <silent> <buffer> <Plug>TodoAddinsert -[] 
inoremap <expr> <silent> <buffer> <Plug>TodoCheckinsert <SID>SearchCheck() ? '<esc>:.s/\[\]/\[x\]<Enter>' : '<esc>:.s/\[x\]/\[\]<Enter>' 
