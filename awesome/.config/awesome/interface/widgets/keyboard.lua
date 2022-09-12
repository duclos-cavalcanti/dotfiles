local awful = require("awful")
local wibox = require("wibox")

local M = {}

function M.default()
    return awful.widget.keyboardlayout()
end

return M

