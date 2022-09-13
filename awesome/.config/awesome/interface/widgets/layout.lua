local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local M = {}

function M.default(s)
    return awful.widget.layoutbox(s)
end

function M.rounded(s, radius)
    local w = awful.widget.layoutbox(s)

    return wibox.widget {
        bg = beautiful.colors.bg,
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
