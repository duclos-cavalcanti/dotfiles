-- Editor keymaps. Plugin keymaps live in each plugin's config file
-- (e.g. LSP in plugins/core.lua, picker in plugins/pick.lua).
local utils = require("utils")
local map = vim.keymap.set

-- tabs: move current tab left/right
vim.api.nvim_set_keymap("n", "<C-w>>", ":tabmove +1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-w><lt>", ":tabmove -1<CR>", { noremap = true, silent = true })

-- terminal mode: escape to normal / window commands
vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-w>", "<C-\\><C-N><C-w>", { noremap = true, silent = true })

-- toggle a single reusable bottom-split terminal
map("n", "<leader><space>", utils.toggle_terminal, { silent = true, desc = "Toggle Terminal" })

-- quickfix navigation (only acts when the quickfix window is open)
map("n", "<C-n>", function()
    if utils.is_quickfix_open() then vim.cmd("cnext") end
end, { silent = true, desc = "Next quickfix item" })
map("n", "<C-p>", function()
    if utils.is_quickfix_open() then vim.cmd("cprev") end
end, { silent = true, desc = "Prev quickfix item" })

-- markdown preview in the macOS app
map("n", "<leader>mp", utils.open_markdown_preview, { silent = true, desc = "Open buffer in Markdown Preview.app" })
