vim.g.custom_transparent = true
vim.g.custom_transparent_sidebar = true
vim.g.custom_italic_functions = true
vim.g.custom_lualine_bold = true
vim.g.custom_cursorline = false
vim.g.custom_columnline = false
vim.g.custom_palette = "test"

vim.cmd[[colorscheme boo]]

require('lualine').setup {
    options = {
        theme = 'custom',
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

