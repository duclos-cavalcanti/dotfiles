local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local M = {}

function M.output()
end

function M.default()
    local command = {}
    local out = function()
    end

    local cb = function()
        awful.spawn_easy_async(command, M.output)
    end

    local timer = make_timer({
        timeout = 30,
        callback = cb
    })
end

return M

