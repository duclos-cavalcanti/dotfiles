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
                "bash -c 'free | grep -z Mem.*Swap.* | head -n 2 | tail -n 1'",
                function(out, err, exitreason, exitcode)
                    local arr = {}
                    local sep = " "

                    -- splits string by separator, similar to split in Python
                    for str in string.gmatch(out, "([^" .. sep .. "]+)") do
                       table.insert(arr, str)
                    end

                    local total = tonumber(arr[2])
                    local used  = tonumber(arr[3])
                    local free  = tonumber(arr[4])

                    local output = string.format("%.2f%%", ((used/total) * 100))
                    local text = "ram: "
                                 .. utils.color_text(
                                            beautiful.colors.cyan,
                                            output)

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

