local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local M = {}

function M.default()
    local w = wibox.widget.systray()
    w.base_size = beautiful.systray_icon_size

    return w
end

function M.rounded(radius)
    local w = wibox.widget.systray()
    w.base_size = beautiful.systray_icon_size

    return wibox.widget {
        bg = beautiful.colors.bg,
        fg = beautiful.colors.cyan,
        shape = function(cr, width, height)
          gears.shape.rounded_rect(cr, width, height, radius)
        end,
        widget = wibox.container.background,
        {
          widget = w,
        },
    }
end


return M


