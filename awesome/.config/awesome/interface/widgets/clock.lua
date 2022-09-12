local awful = require("awful")
local wibox = require("wibox")

local M = {}

function M.default()
    return wibox.widget.textclock()
end

return M

