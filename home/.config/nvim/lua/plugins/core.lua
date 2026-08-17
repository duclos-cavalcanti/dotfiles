-- Treesitter
require("nvim-treesitter").install({
    "bash",
    "c",
    "c_sharp",
    "cmake",
    "cpp",
    "css",
    "html",
    "java",
    "javascript",
    "json",
    "yaml",
    "lua",
    "make",
    "nix",
    "python",
    "query",
    "rust",
    "vim",
    "vimdoc",
})

-- Completion
require("mini.completion").setup()

-- Auto-pairs
require("mini.pairs").setup()

-- Snippets
require("mini.snippets").setup({
    snippets = { require("mini.snippets").gen_loader.from_lang() },
    -- default <C-j>; jump_next/prev stay <C-l>/<C-h>
    mappings = { expand = "<C-k>" },
})

-- Diff
require("mini.diff").setup({
    -- Default apply/reset are `gh`/`gH`; `gh` collides with LSP signature_help
    -- (core.lua). Move hunk actions under the <leader>g git namespace. Hunk
    -- navigation stays on ]h / [h (mini.diff defaults).
    mappings = {
        apply = "<leader>gh",
        reset = "<leader>gH",
    },
})

-- Git
require("mini.git").setup()
