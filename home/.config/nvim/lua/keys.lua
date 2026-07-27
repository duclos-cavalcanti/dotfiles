-- Global keymaps (editor + plugin). Buffer-local/context maps live with their
-- setup: LSP in autocmds.lua (LspAttach), picker in plugins/pick.lua.
local utils = require("utils")
local map = vim.keymap.set

-- tabs: move current tab left/right
vim.api.nvim_set_keymap("n", "<C-w>>", ":tabmove +1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-w><lt>", ":tabmove -1<CR>", { noremap = true, silent = true })

-- terminal mode: escape to normal / window commands
vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-w>", "<C-\\><C-N><C-w>", { noremap = true, silent = true })

map("n", "<leader><space>", utils.toggle_terminal, { silent = true, desc = "Toggle Terminal" })

-- completion: <CR> accepts the selected pmenu item (else dismiss + newline).
-- expr map; keycodes are already raw, so disable replace_keycodes.
map("i", "<CR>", function()
    if vim.fn.pumvisible() == 0 then return vim.keycode("<CR>") end
    return vim.fn.complete_info().selected ~= -1 and vim.keycode("<C-y>") or vim.keycode("<C-y><CR>")
end, { expr = true, replace_keycodes = false })

-- quickfix navigation (only acts when the quickfix window is open)
map("n", "<C-n>", function()
    if utils.is_quickfix_open() then vim.cmd("cnext") end
end, { silent = true, desc = "Next quickfix item" })
map("n", "<C-p>", function()
    if utils.is_quickfix_open() then vim.cmd("cprev") end
end, { silent = true, desc = "Prev quickfix item" })

-- markdown preview in the macOS app
map("n", "<leader>mp", utils.open_markdown_preview, { silent = true, desc = "Open buffer in Markdown Preview.app" })

map("n", "<C-g>f", "<cmd>AgenticSendFile<CR>",       { desc = "Agentic: send file ref" })
map("x", "<C-g>i", ":<C-u>AgenticSendSelection<CR>", { desc = "Agentic: send selection ref" })
map("n", "<C-g>r", "<cmd>AgenticRegister<CR>",       { desc = "Agentic: register tmux session" })
