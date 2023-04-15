vim.cmd [[ command! GitUpdate :!git add --all && git commit -m 'Update' && git push ]]
vim.cmd [[ autocmd Signal SIGWINCH wincmd = ]]
vim.cmd [[ autocmd TermEnter term://* setlocal scl=no | setlocal nohidden | setlocal norelativenumber | setlocal nonu ]]
vim.cmd [[ autocmd BufHidden term://* q! ]]

