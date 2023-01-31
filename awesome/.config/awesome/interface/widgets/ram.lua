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
                "bash -c 'free | grep -z Mem.*Swap.* | tail -n 3'",
                function(out, err, exitreason, exitcode)
                    local arr= {}
                    local sep = "\n"
                    for str in string.gmatch(out, "([^" .. sep .. "]+)") do
                       table.insert(arr, str)
                    end

                    local mem  = arr[1]
                    local swap = arr[2]

                    arr= {}
                    sep = " "
                    for str in string.gmatch(mem, "([^" .. sep .. "]+)") do
                       table.insert(arr, str)
                    end

                    local total = tonumber(arr[2])
                    local used  = tonumber(arr[3])
                    local free  = tonumber(arr[4])
                    local output_ram = string.format("%.2f%%", ((used/total) * 100))

                    arr= {}
                    sep = " "
                    for str in string.gmatch(swap, "([^" .. sep .. "]+)") do
                       table.insert(arr, str)
                    end

                    total = tonumber(arr[2])
                    used  = tonumber(arr[3])
                    free  = tonumber(arr[4])
                    local output_swap = string.format("%.2f%%", ((used/total) * 100))

                    local text = "ram: "
                                 .. utils.color_text(
                                            beautiful.wibar_fg_highlight,
                                            output_ram)
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

