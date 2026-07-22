-- Fuzzy picker: mini.pick (declared in plugins/init.lua).
require("mini.pick").setup()

local pick = MiniPick.builtin

vim.keymap.set("n", "<leader>sf", function() pick.files() end,     { desc = "Find files" })
vim.keymap.set("n", "<leader>sg", function() pick.grep_live() end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>sb", function() pick.buffers() end,   { desc = "Find buffers" })
vim.keymap.set("n", "<leader>sh", function() pick.help() end,      { desc = "Help tags" })
