-------------------
-- COMMANDS
-------------------
vim.cmd [[ command! GitUpdate :!git add --all && git commit -m 'Update' && git push ]]

-------------------
-- AUTOCOMMANDS
-------------------
vim.cmd [[ autocmd Signal SIGWINCH wincmd = ]]
vim.cmd [[ autocmd TermEnter term://* setlocal nohidden ]]
vim.cmd [[ autocmd BufHidden term://* q! ]]

