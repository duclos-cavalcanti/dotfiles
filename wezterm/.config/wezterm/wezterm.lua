local wezterm = require("wezterm")
local colors = require("colors")
local keys = require("keys")

return {
    -- basics
    font = wezterm.font 'UbuntuMono',
    font_size = 11.4,
    cell_width = 0.8,

    color_scheme = 'Batman',

    -- keybindings
    keys = keys.base,
    key_tables = keys.tables,
    mouse_bindings = keys.mouse,

    -- ui
    window_padding = {
        left =  5,
        right = 0,
        top = 5,
        bottom = 2,
    },

    -- settings
    scrollback_lines = 3500,
    hide_tab_bar_if_only_one_tab = false,
    window_close_confirmation = "NeverPrompt",
}
