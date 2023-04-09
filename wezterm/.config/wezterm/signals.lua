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

wezterm.on('gui-startup',
function(arg)
    if not arg then
        wezterm.mux.spawn_window({})
        return
    end

    local function exists(dir)
        local f = io.open(dir,"r")
        if f ~= nil then io.close(f) return true else return false end
    end

    local function spawn_window_err(txt)
        wezterm.mux.spawn_window({
            args = txt,
        })
    end

    for _, session in pairs(require("sessions")) do
        if session.name == arg.args[1] then
            local initial_pane = nil
            local tab, pane, window = nil, nil, nil

            if not exists(session.dir) then
                spawn_window_err(string.format("echo ERROR: %s is not a valid directory", session.dir))
                return
            end

            tab, pane, window = wezterm.mux.spawn_window({
                workspace = session.name,
                cwd = session.dir,
            })

            initial_pane = pane
            for i,t in ipairs(session.tabs) do
                if i > 1 then
                    tab, pane, window = window:spawn_tab {}
                else
                end
                for j,cmd in ipairs(t.cmds) do
                    if t.dir ~= nil then
                        pane:send_text(string.format("cd %s\n", t.dir))
                    end
                    pane:send_text(string.format("%s\n", cmd))
                    if j < #t.cmds then
                        pane = pane:split({
                            direction = t.direction or "Right",
                            size = 0.5
                        })
                    end
                end
                window:active_tab():set_title(t.name)
            end

            initial_pane:activate()
            return
        end
    end

    spawn_window_err(string.format("Could not find predetermined session: %s", arg.args[1]))
end)

return {}
