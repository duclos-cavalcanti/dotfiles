-- colorscheme
local scheme="adwaita"
vim.cmd('colorscheme ' .. scheme)

vim.g.adwaita_darker = true

-- statusline
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

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
