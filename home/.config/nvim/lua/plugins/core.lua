-- Core editing config: treesitter, LSP, and the local agentic plugin.
-- Plugins declared in plugins/init.lua (agentic is a local pack/start plugin,
-- not vim.pack-managed).

-- Treesitter -----------------------------------------------------------------
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
-- nvim-lspconfig removed: each server is a self-contained base config in
-- `lsp/<name>.lua` (cmd + filetypes + root_markers). To add a server: drop a
-- `lsp/<name>.lua` and list it here.
vim.lsp.enable({
    "bashls",
    "lua_ls",
    "marksman",
    "rust_analyzer",
})

-- Completion -----------------------------------------------------------------
require("mini.completion").setup()

-- Agentic --------------------------------------------------------------------
-- Local plugin under pack/plugins/start/agentic, auto-sourced by Neovim at
require("agentic").setup()
