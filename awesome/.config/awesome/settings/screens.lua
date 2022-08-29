local awful = require("awful")
local gears = require("gears")

local h_bar               = require("interface.horizontal_bar")
local v_bar               = require("interface.vertical_bar")

local M = {}

-- checks if the current screen is a vertical one
local function set_wallpaper(s)
    local w = s.geometry.width
    local h = s.geometry.height

    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper

        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end

       -- awful.spawn.with_shell(string.format("hsetroot -solid '%s'", beautiful.colors.wallpaper))
       if w > h then   -- horizontal
           gears.wallpaper.maximized(wallpaper, s, true)
       else            -- vertical
           gears.wallpaper.maximized(vertical_wallpaper, s, false)
       end
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
        h_bar.setup(s)                                  -- setting up bar
        -- v_bar.setup(s)                                  -- setting up vertical bar
    end)
end

return M
