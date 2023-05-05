require('nvim-treesitter.configs').setup({
	highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    autotag = { -- html auto-tagging
        enable = true,
        filetypes = {"html", "xml", "markdown", "md"},
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
    "gomod",
    "gowork",
    "java",
    "json",
    "yaml",
    "vim"
	},
})
