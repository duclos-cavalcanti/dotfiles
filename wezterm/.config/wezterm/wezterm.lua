local wezterm = require("wezterm")
local keys = require("keys")
local theme = require("theme")
local _ = require("signals")

local config = {
    -- basics
    font = wezterm.font 'UbuntuMono',
    font_size = 10.5,
    cell_width = 1.0,

    -- theme / ui
    colors = theme.colors,
    background = theme.background,

    window_padding = {
        left =  5,
        right = 10,
        top = 5,
        bottom = 5,
    },

    default_cursor_style = "BlinkingUnderline",
    cursor_blink_rate = 800,

    status_update_interval = 1000,

    inactive_pane_hsb = {
      saturation = 1.0,
      brightness = 1.0,
    },

    enable_scroll_bar = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom  = true,

    hide_tab_bar_if_only_one_tab = false,

    -- keybindings
	disable_default_key_bindings = true,

    leader = keys.leader,
    keys = keys.base,
    key_tables = keys.tables,
    mouse_bindings = keys.mouse,

    -- settings
    scrollback_lines = 3500,
    window_close_confirmation = "NeverPrompt",
}

return config
