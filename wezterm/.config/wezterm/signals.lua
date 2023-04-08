local wezterm = require("wezterm")
local theme = require("theme")

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

-- allow `wezterm start -- something` to affect what we spawn
wezterm.on('gui-startup',
function(arg)
    if not arg then return end
    for _, session in pairs(require("sessions")) do
        if session.name == arg then
            local pane,window = nil, nil
            _, pane, window = wezterm.mux.spawn_window({
                workspace = session.name,
                cwd = session.dir,
            })

            for i,tab in ipairs(session.tabs) do
                window:set_title(tab.name)

                for j,cmd in ipairs(tab.cmds) do
                    pane:send_text(string.format("%s\n", cmd))
                    if j < #panes then
                        pane = pane:split({
                            direction = tab.direction or "Right",
                            size = 0.5
                        })
                    end
                end

                if i < #session.tabs then
                    _, pane, window = window:spawn_tab {}
                end
            end
        end
    end
end)

return {}
