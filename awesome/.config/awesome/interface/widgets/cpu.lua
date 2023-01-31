local awful = require("awful")
local wibox = require("wibox")

local utils = require("utils")

-- requires mpstat installed
local M = {}

function M.new()
    local ok = false
    M.w = wibox.widget.textbox()

    local function callback()
        awful.spawn.easy_async(
                "bash -c 'mpstat | tail -n 1'",
                function(out, err, exitreason, exitcode)
                    local arr = {}
                    local sep = " "

                    -- splits string by separator, similar to split in Python
                    for str in string.gmatch(out, "([^" .. sep .. "]+)") do
                       table.insert(arr, str)
                    end

                    local idle = arr[13]
                    local text = "cpu: "
                                 .. utils.color_text(
                                            beautiful.wibar_fg_highlight,
                                            string.format("%s%%", (100 - idle)))

                    M.w.markup = text
                end
            )
    end

    M.timer, ok = utils.set_timer({
        timeout = 5,
        callback = callback
    })
end

function M.widget()
    return M.w
end

return M
