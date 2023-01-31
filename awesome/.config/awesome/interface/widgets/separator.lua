local awful = require("awful")
local wibox = require("wibox")

local M = {}

function M.default(h)
    return wibox.widget {
        {
           forced_width     = 1,
           forced_height    = h - 5,
           thickness        = 1,
           border_width     = 2,
           color            = beautiful.separator_fg,
           widget           = wibox.widget.separator
         },
         valign = 'center',
         halign = 'center',
         widget = wibox.container.place
    }
end

return M


