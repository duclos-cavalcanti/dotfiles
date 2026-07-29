vim.cmd([[setlocal syntax=markdown]])
vim.cmd([[setlocal wrap]])
vim.cmd([[setlocal spell spelllang=en_us]])

vim.cmd [[setlocal expandtab ]]
vim.cmd [[setlocal tabstop=2 ]]
vim.cmd [[setlocal softtabstop=2]]
vim.cmd [[setlocal shiftwidth=2]]
vim.cmd [[setlocal wrap]]
-- Hard-wrap at 80: insert a real newline once a line crosses the threshold.
vim.opt_local.textwidth = 80
vim.opt_local.formatoptions:append("t") -- auto-wrap text using textwidth
vim.opt_local.colorcolumn = "80"        -- visual guide at the limit

-- Preview is handled by the global <leader>mp mapping in config.lua
-- (open the file in Markdown Preview.app); no buffer-local override needed.
