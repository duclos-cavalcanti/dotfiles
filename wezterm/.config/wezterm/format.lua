local wezterm = require("wezterm")

wezterm.on('update-right-status', function(window, pane)
    local ssh = pane:get_domain_name()
    local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'
    local win = pane:get_workspace()
    window:set_right_status(wezterm.format {
      { Attribute = { Underline = 'Single' } },
      { Attribute = { Italic = true } },
      { Text = string.format("%s | %s | %s", win, ssh, date) },
    })
end)

return {}
