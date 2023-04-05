local palette = os.getenv("HOME") .. "/" .. ".dotfiles/assets/system.lua"
local config = {
    transparent            = false,
    cursorline             = true,
    colorcolumn            = true,
    columnline             = false,

    inactive_statusline    = true,

    comment_style          = "italic",
    function_style         = "italic",
    keyword_style          = "italic",
    variable_style         = "NONE",

    lualine_bold           = false,
}

require("schemer").setup(config, palette)
require('lualine').setup {
    options = {
        theme = "schemer",
        component_separators = {left = '', right = ''},
        section_separators = {left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'filename', 'diff'},
        lualine_c = {'branch'},
        lualine_x = {'location'},
        lualine_y = {'progress'},
        lualine_z = {'filetype'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
