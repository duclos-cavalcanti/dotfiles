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
require("mini.completion").setup()

-- Agentic --------------------------------------------------------------------
-- Local plugin under pack/plugins/start/agentic, auto-sourced by Neovim at
require("agentic").setup()
