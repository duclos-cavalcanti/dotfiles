local wezterm = require("wezterm")
local keys = require("keys")
local ui = require("ui")

local config = {
    -- basics
    font = wezterm.font 'UbuntuMono',
    font_size = 11.4,
    cell_width = 0.8,

    -- ui
    colors = ui.colors,
    window_padding = ui.window_padding,
    window_frame = ui.window_frame,

    tab_bar_at_bottom  = false,
    hide_tab_bar_if_only_one_tab = false,

    -- keybindings
    keys = keys.base,
    key_tables = keys.tables,
    mouse_bindings = keys.mouse,

    -- settings
    scrollback_lines = 3500,
    window_close_confirmation = "NeverPrompt",
}


config.window_frame.font = wezterm.font 'UbuntuMono'
config.window_frame.font_size = 12

return config
