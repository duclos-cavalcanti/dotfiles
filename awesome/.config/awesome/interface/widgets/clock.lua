local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local M = {}

function M.default(format)
    return wibox.widget {
      bg = beautiful.clock.bg,
      fg = beautiful.clock.fg,
      shape = function(cr, width, height)
        gears.shape.rectangle(cr, width, height)
      end,
      widget = wibox.container.background,
      {
        widget = wibox.widget.textclock(format),
      },
    }
end

return M

