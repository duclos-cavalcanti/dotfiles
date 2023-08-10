local utils = require("utils")
local dpi = require("beautiful.xresources").apply_dpi

-- Global Variables
modkey          = "Mod4" --super
altkey          = "Mod1"

terminal         = "wezterm start --class Wezterm"
terminal_scratch = "wezterm start --class scratch"

taglist = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
bar_height = dpi(20)
bar_position = "bottom"
notification_position = "top_right"
titlebar_height = dpi(25)
gaps = dpi(0)
border_width = dpi(1)


local M = {}

function M.setup()
    local error = require("settings.error")
    local autostart = require("settings.autostart")
    local screens = require("settings.screens")
    local keys = require("settings.keys")
    local layouts = require("settings.layouts")
    local rules = require("settings.rules")
    local clients = require("settings.clients")
    local notifications = require("settings.notifications")

    -- settings/config
    error.setup()           -- debugging rc errors through naughty

    layouts.setup()         -- tiling layouts
    screens.setup()         -- sets bar, widgets and wallpaper
    keys.setup()            -- keybindings and sets popup menu
    autostart.setup()       -- autostarts programs
    rules.setup(keys)       -- sets rules for specific clients/windows
    clients.setup()         -- sets client hooks and titlebar
    notifications.setup()   -- sets notifications

    -- bar, widgets, titlebar and menu are in interface folder
end

return M
