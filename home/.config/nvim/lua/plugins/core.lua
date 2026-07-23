-- Core editing config: treesitter, LSP, and the local agentic plugin.
-- Plugins declared in plugins/init.lua (agentic is a local pack/start plugin,
-- not vim.pack-managed).

-- Treesitter -----------------------------------------------------------------
-- nvim-treesitter `main` branch: install the parser set here. Highlighting is
-- core `vim.treesitter.start`, triggered per buffer by the FileType autocmd in
-- lua/autocmds.lua. Parser recompiles run via the build hook in plugins/init.lua.
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

-- LSP ------------------------------------------------------------------------
-- Native 0.11 path. Server definitions (cmd/filetypes/root markers) come from
-- nvim-lspconfig's lsp/*.lua on the runtimepath; per-server overrides live in
-- ~/.config/nvim/lsp/*.lua and are merged over them by core. Here we only enable
-- servers -- on-attach keymaps live in lua/autocmds.lua (LspAttach), diagnostics
-- display in lua/config.lua + lua/autocmds.lua. All editor-wide, not LSP-specific.
-- (Completion capabilities are added later by the completion port.)
vim.lsp.enable({
    "bashls",
    "clangd",
    "csharp_ls",
    "cssls",
    "denols",
    "gopls",
    "html",
    "lua_ls",
    "marksman",
    "metals",
    "pyright",
    "rust_analyzer",
    "yamlls",
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
