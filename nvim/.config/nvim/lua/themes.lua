vim.g.custom_transparent            = false
vim.g.custom_italic_functions       = true
vim.g.custom_lualine_bold           = false
vim.g.custom_cursorline             = true
vim.g.custom_columnline             = false
vim.g.custom_colorcolumn            = true
vim.g.custom_inactive_statusline    = true
vim.g.custom_palette                = "04"
vim.g.custom_palette_dir            = "/home/duclos/.dotfiles/assets/themes/palette"
local scheme = "custom"

vim.cmd("colorscheme" .. " " .. scheme)
require('lualine').setup {
    options = {
        theme = scheme,
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

