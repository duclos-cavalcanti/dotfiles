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
    rainbow = {
        enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
      },
})
