local wezterm = require("wezterm")
local ui = require("ui")

wezterm.on('update-status', function(window, pane)
    local mode = window:active_key_table()
    local ssh = pane:get_domain_name()
    local win = window:active_workspace()

    window:set_right_status(wezterm.format {
      { Foreground = { Color = ui.status.mode } },
      { Text = string.format("%s", mode) },
      { Foreground = { Color = ui.status.foreground } },
      { Text = string.format(" - %s@", ssh) },
      { Foreground = { Color = ui.status.ws } },
      { Text = string.format("%s", win) },
    })
end)

return {}
