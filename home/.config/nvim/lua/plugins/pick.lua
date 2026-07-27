-- Fuzzy picker: mini.pick + mini.extra (declared in plugins/init.lua).
require("mini.pick").setup()
require("mini.extra").setup()   -- adds LSP/diagnostic/git/etc. pickers

local pick = MiniPick.builtin

vim.keymap.set("n", "<leader>sf", function()
    MiniPick.builtin.cli(
        { command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!.git" } },
        { source = { name = "Files", cwd = vim.fn.getcwd() } }
    )
end, { desc = "Find files (hidden + ignored)" })

vim.keymap.set("n", "<leader>sg", function() pick.grep_live() end, { desc = "Live grep" })
-- Buffers picker; <C-d> wipes out the buffer under the cursor
-- (<C-x> stays mini.pick's default 'mark'). Canonical wipeout from :h MiniPick.builtin.buffers.
local function buffers()
    local wipeout = function() vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {}) end
    pick.buffers({}, { mappings = { wipeout = { char = "<C-d>", func = wipeout } } })
end

vim.keymap.set("n", "<leader>sb", buffers,                         { desc = "Find buffers (<C-d> wipeout)" })
vim.keymap.set("n", "<leader>sh", function() pick.help() end,      { desc = "Help tags" })
vim.keymap.set("n", "<leader><Tab>", function() MiniExtra.pickers.lsp({ scope = "document_symbol" }) end, { desc = "LSP symbols (document)" })
vim.keymap.set("n", "<leader><S-Tab>", function() MiniExtra.pickers.lsp({ scope = "workspace_symbol" }) end, { desc = "LSP symbols (workspace)" })
