-- Core editing config: treesitter, LSP, and the local agentic plugin.
-- Plugins declared in plugins/init.lua (agentic is a local pack/start plugin,
-- not vim.pack-managed).

-- Treesitter -----------------------------------------------------------------
-- nvim-treesitter `main` branch: parsers installed via .install(), highlighting
-- is core `vim.treesitter.start` per buffer (main dropped the plugin's own
-- highlighter). Parser recompiles run via the build hook in plugins/init.lua.
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

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- LSP ------------------------------------------------------------------------
-- Native 0.11 path. Server definitions (cmd/filetypes/root markers) come from
-- nvim-lspconfig's lsp/*.lua on the runtimepath; per-server overrides live in
-- ~/.config/nvim/lsp/*.lua and are merged over them by core. Here we only enable
-- servers, configure diagnostics, and bind keys on attach.
-- (Completion capabilities are added later by the completion port.)
vim.diagnostic.config({ virtual_text = false })

-- Diagnostics float on hover (CursorHold; 'updatetime' set in config.lua).
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function() vim.diagnostic.open_float(nil, { focus = false }) end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP buffer keymaps",
    callback = function(args)
        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "Goto definition")
        map("gD", vim.lsp.buf.declaration, "Goto declaration")
        map("gi", vim.lsp.buf.implementation, "Goto implementation")
        map("gh", vim.lsp.buf.signature_help, "Signature help")
        map("GT", vim.lsp.buf.type_definition, "Goto type definition")
        map("K", vim.lsp.buf.hover, "Hover")
        map("<leader>R", vim.lsp.buf.rename, "Rename")
        map("gn", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
        map("gp", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
        map("gf", vim.diagnostic.open_float, "Diagnostic float")
    end,
})

vim.lsp.enable({
    "clangd", "gopls", "metals", "marksman", "csharp_ls", "denols",
    "rust_analyzer", "cssls", "html", "pyright", "lua_ls", "yamlls", "bashls",
})

-- Completion -----------------------------------------------------------------
-- mini.completion: automatic two-stage insert-mode completion (LSP first,
-- keyword fallback) + signature help. Defaults already emulate the old cmp keys:
-- <C-Space> force-trigger, <C-n>/<C-p> navigate (native pmenu), <C-f>/<C-b>
-- scroll docs, <C-e> cancel.
-- 'completeopt' (menuone,noinsert,noselect) is set in config.lua.
require("mini.completion").setup()

-- <CR> accepts the selected item (or dismisses + newline), matching the old
-- <CR>=confirm. keycodes are already raw, so disable replace_keycodes.
vim.keymap.set("i", "<CR>", function()
    if vim.fn.pumvisible() == 0 then return vim.keycode("<CR>") end
    return vim.fn.complete_info().selected ~= -1 and vim.keycode("<C-y>") or vim.keycode("<C-y><CR>")
end, { expr = true, replace_keycodes = false })

-- agentic --------------------------------------------------------------------
-- Local plugin under pack/plugins/start/agentic, auto-sourced by Neovim at
-- startup, so it is NOT managed by vim.pack -- only configured here.
require("agentic").setup()

local map = vim.keymap.set
map("n", "<C-g>f", "<cmd>AgenticSendFile<CR>",       { desc = "Agentic: send file ref" })
map("x", "<C-g>i", ":<C-u>AgenticSendSelection<CR>", { desc = "Agentic: send selection ref" })
map("n", "<C-g>r", "<cmd>AgenticRegister<CR>",       { desc = "Agentic: register tmux session" })
