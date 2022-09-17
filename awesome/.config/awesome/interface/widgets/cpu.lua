local awful = require("awful")
local wibox = require("wibox")

local utils = require("utils")
local icon = beautiful.custom_icons.cpu_icon

-- requires mpstat installed
local M = {}

function M.new()
    local ok = false
    M.w = wibox.widget.textbox("", false)

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

                    local user = arr[4]
                    local sys = arr[6]
                    local output = string.format("user %s%% / sys %s%%",
                                                       user, sys)
                    local text = "cpu: "
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
