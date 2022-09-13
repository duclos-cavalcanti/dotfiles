local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local M = {}

function M.default()
    return wibox.widget.textclock()
end

function M.rounded(radius)
    return wibox.widget {
      bg = beautiful.clock.bg,
      fg = beautiful.clock.fg,
      shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
      end,
      widget = wibox.container.background,
      {
        widget = wibox.widget.textclock,
      },
    }
end

function M.rect()
    return wibox.widget {
      bg = beautiful.clock.bg,
      fg = beautiful.clock.fg,
      shape = function(cr, width, height)
        gears.shape.rectangle(cr, width, height)
      end,
      widget = wibox.container.background,
      {
        widget = wibox.widget.textclock(),
      },
    }
end

return M

