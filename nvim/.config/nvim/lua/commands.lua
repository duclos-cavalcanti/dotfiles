-- Open help tags
vim.cmd("command! HelpTags Telescope help_tags")

-- Remove trailing whitespaces
vim.cmd("command! DebuggerBreak lua require'dap'.continue()")
vim.cmd("command! DebuggerContinue lua require'dap'.continue()")

-- overwrite annoying :W
vim.cmd("command! W write")

-- Remove trailing whitespaces
vim.cmd [[autocmd BufWritePre * %s/\s\+$//e ]]
