local wezterm = require("wezterm")
local theme = require("theme")

local sessions = {
    dotfiles = {
        name = "dotfiles"
    }
}

wezterm.on('update-status',
function(window, pane)
    local mode = window:active_key_table()
    local ssh = pane:get_domain_name()
    local win = window:active_workspace()

    window:set_right_status(wezterm.format {
      { Foreground = { Color = theme.status.mode } },
      { Text = string.format("%s", mode) },
      { Foreground = { Color = theme.status.foreground } },
      { Text = string.format(" - %s@", ssh) },
      { Foreground = { Color = theme.status.ws } },
      { Text = string.format("%s", win) },
    })
end)


wezterm.on('gui-startup',
function(cmd)
end)

return {}
