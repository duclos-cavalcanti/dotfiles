require('nvim-treesitter.configs').setup({
	highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
	ensure_installed = {
    "bash",
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
	},
})
