local naughty = require("naughty")
local awful = require("awful")
local gears = require("gears")

local dpi = require("beautiful.xresources").apply_dpi

local M = {}

function M.setup()
    naughty.config.defaults.title = "Notification"
    naughty.config.defaults.ontop = true
    naughty.config.defaults.timeout = 5
    naughty.config.defaults.position = "bottom_right"
    naughty.config.defaults.screen = awful.screen.focused()

    naughty.persistence_enabled = true

    naughty.config.padding = dpi(10)
    naughty.config.spacing = dpi(1)
    naughty.config.defaults.shape = function(cr, width, height)
                                        gears.shape.rounded_rect(cr, width, height, 2)
                                    end
end

return M
