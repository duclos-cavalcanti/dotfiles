local awful = require("awful")

local utils = require("utils")
local config_path = utils.config_path

local M = {}

local function spawn_once()
    local auto = {
        "picom",
        "nm-applet",
        "blueman-applet",
        "pasystray",
        "unclutter",
    }

    for k,v in pairs(auto) do
        local command = string.format("%s/autorun.sh %s", config_path(), v)
        _ = awful.spawn.with_shell(command)
    end
end

local function spawn_always()
    local auto = {
        "xmodmap ~/.config/X11/Xmodmap",
    }

    for k,v in pairs(auto) do
        _ = awful.spawn.with_shell(string.format("%s &", v))
    end
end

function M.setup()
    spawn_once()
    spawn_always()
end

return M
