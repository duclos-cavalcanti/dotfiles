local awful = require("awful")
local gears = require("gears")

local M = {}

local function wp(s, hwp, vwp)
    local w = s.geometry.width
    local h = s.geometry.height

    if w > h then   -- horizontal
        gears.wallpaper.maximized(hwp, s, false)
    else            -- vertical
        gears.wallpaper.maximized(vwp, s, false)
    end
end

local function set_wallpaper(s)
    local hwp   = beautiful.wp
    local vwp   = beautiful.wp2
    wp(s, hwp, vwp)
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
