vim.cmd([[
augroup i3_ftdetect
    au!
    au BufRead,BufNewFile *.tf set ft=hcl
augroup END
]])
