-- Git: mini.diff (hunk signs/nav/overlay) + mini.git (blame/commands).
-- Declared in plugins/init.lua. Replaces gitsigns + codediff.

require("mini.diff").setup({
    -- Default apply/reset are `gh`/`gH`; `gh` collides with LSP signature_help
    -- (core.lua). Move hunk actions under the <leader>g git namespace. Hunk
    -- navigation stays on ]h / [h (mini.diff defaults).
    mappings = {
        apply = "<leader>gh",
        reset = "<leader>gH",
    },
})
require("mini.git").setup()

local map = vim.keymap.set
map("n", "<leader>gp", function() MiniDiff.toggle_overlay() end, { desc = "Git: toggle hunk overlay" })
map({ "n", "x" }, "<leader>gb", function() MiniGit.show_at_cursor() end, { desc = "Git: blame / show at cursor" })
