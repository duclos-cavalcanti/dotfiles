local awful = require("awful")
local wibox = require("wibox")
local utils = require("utils")
local config_path = utils.config_path

local M = {}

function M.setup(c)
    local titlebar_size = require("theme").titlebar_size
    if titlebar_size <= 1 then
        return
    end

    local titlebar = awful.titlebar(c, {
        size = beautiful.titlebar_size,
    })

    local buttons = {}
    local icon = {}

    if beautiful.titlebar_icon == nil then
        icon =  beautiful.titlebar_icon
    else
        icon =  beautiful.awesome_icon
    end

    titlebar : setup {
       { -- Left
           wibox.widget({
               image = icon,
               resize = true,
               widget = wibox.widget.imagebox
           }),
           buttons = buttons,
           layout  = wibox.layout.flex.horizontal
       },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        layout = wibox.layout.align.horizontal,
    }
end

return M
