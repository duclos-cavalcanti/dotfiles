local awful = require("awful")

local M = {}

function M.default(s)
    return awful.widget.layoutbox(s)
end

return M
