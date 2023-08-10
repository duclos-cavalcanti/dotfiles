local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local M = {}

function M.default()
    local w = wibox.widget.systray()
    w.base_size = beautiful.systray_icon_size

    return w
end

return M


