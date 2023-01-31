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
    -- plugin is not supported anymore
    -- rainbow = {
    --     enable = true,
    --         disable = { "c", "cpp" },
    --         extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    --         max_file_lines = nil, -- Do not enable for files with more than n lines, int
    --         -- colors = {}, -- table of hex strings
    --         -- termcolors = {} -- table of colour name strings
    --   },
})
