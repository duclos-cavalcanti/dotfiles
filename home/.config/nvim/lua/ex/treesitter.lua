vim.opt.runtimepath:append("$HOME/.local/share/treesitter")
require('nvim-treesitter.configs').setup({
    parser_install_dir = "$HOME/.local/share/treesitter",
	highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    autotag = { -- html auto-tagging
        enable = true,
        filetypes = {"js", "jsx", "javascript", "html", "xml", "markdown", "md"},
    },
	ensure_installed = {
    "bash",
    "html",
    "javascript",
    "css",
    "c",
    "cpp",
    "cmake",
    "make",
    "rust",
    "python",
    "lua",
    "commonlisp",
    "haskell",
    "go",
    "nix",
    "gomod",
    "gowork",
    "java",
    "json",
    "yaml",
    "vim"
	},
})
