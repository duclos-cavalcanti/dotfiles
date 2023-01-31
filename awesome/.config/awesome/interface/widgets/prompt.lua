local awful = require("awful")

local M = {}

function M.default()
    return awful.widget.prompt({
        prompt = beautiful.prompt_prefix,
    })
end

return M

