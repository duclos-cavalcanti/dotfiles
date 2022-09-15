local awful = require("awful")
local gears = require("gears")

local utils = require("utils")
local config_path = utils.config_path
local theme_path = config_path() .. "theme"
local wallpaper_path = theme_path .. "/wallpapers"

local M = {}

local simple_wallpaper=false
local wallpaper=""

if simple_wallpaper then
    wallpaper = ""
else
    wallpaper = wallpaper_path .. "/" .. "default.jpg"
end

local function wp(s, hwp, vwp)
    local w = s.geometry.width
    local h = s.geometry.height

    if w > h then   -- horizontal
        gears.wallpaper.maximized(hwp, s, true)
    else            -- vertical
        gears.wallpaper.maximized(vwp, s, false)
    end
end

-- checks if the current screen is a vertical one
local function set_wallpaper(s)
    local step = 6
    if simple_wallpaper then
        awful.spawn.with_shell(string.format("~/.bin/wall.sh '%s' '%s' %d",
                               beautiful.colors.black,
                               beautiful.colors.grey,
                               step))
    else
        wp(s, wallpaper, wallpaper)
    end
end

function M.setup()
    -- screen property hook
    screen.connect_signal("property::geometry", function(s)
        set_wallpaper(s)                                -- setting wallpaper
    end)

    -- screen hook for each screen
    awful.screen.connect_for_each_screen(function(s)
        set_wallpaper(s)                                -- setting wallpaper
        awful.tag(taglist, s, awful.layout.layouts[1])  -- setting taglist per screen
        require("interface.bar").setup(s)               -- setting up bar
    end)
end

return M
