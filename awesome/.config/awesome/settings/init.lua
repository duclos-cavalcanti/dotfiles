local fetch_colors = require("theme.colors")
local dpi = require("beautiful.xresources").apply_dpi

-- Global Variables
modkey          = "Mod4" --super
altkey          = "Mod1"

terminal        = "alacritty"
terminal_class  = "Alacritty"
editor          = os.getenv("EDITOR") or "vim"
edit            = terminal .. " -e " .. editor

-- screens and tags
taglist         = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

-- bar
bar_height      = dpi(20) -- 20
gaps            = dpi(0)

-- theme/wallpaper
font_family     = "Iosevka" -- DejaVuSansMono
palette         = "test"
colors          = fetch_colors.setup(palette)

wallpaper       = "umbrella.jpg"
v_wallpaper     = wallpaper

local M = {}

function M.setup()
    local error = require("settings.error")
    local autostart = require("settings.autostart")
    local screens = require("settings.screens")
    local keys = require("settings.keybindings")
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
