local wezterm = require("wezterm")
local keys = require("keys")
local theme = require("theme")
local _ = require("signals")

local config = {
    -- basics
    font = wezterm.font_with_fallback {
        'Ubuntu Mono',
        "JetBrains Mono",
        "Symbols Nerd Fonto Mono"
    },

    font_size = 12.0,
    cell_width = 1.0,
    
    adjust_window_size_when_changing_font_size = false,

    -- theme / ui
    colors = theme.colors,
    window_background_image = theme.window_background_image,
    window_background_image_hsb = theme.window_background_image_hsb,
    unzoom_on_switch_pane = true,

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
      brightness = 0.7,
    },

    enable_scroll_bar = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom  = true,

    hide_tab_bar_if_only_one_tab = true,

    -- keybindings
	disable_default_key_bindings = true,

    leader = keys.leader,
    keys = keys.base,
    key_tables = keys.tables,
    mouse_bindings = keys.mouse,

    -- settings
    scrollback_lines = 3500,
    window_close_confirmation = "NeverPrompt",
    check_for_updates = false,
}

return config
