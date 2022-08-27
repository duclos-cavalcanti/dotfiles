local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local block = require("interface.widgets.block")

local M = {}
local h_ratio = 0.8
local v_ratio = 0.7

function M.setup(s)

    local w, h, w_screen, h_screen
    local margin, radius
    local x, y

    w_screen = s.geometry.width
    h_screen = s.geometry.height
    w = w_screen * h_ratio
    h = h_screen * v_ratio

    radius = 5
    margin = 15

    x = screen_width / 2
    y = screen_height / 2

    local profile
    profile = require("interface.widgets.profile").new(w - margin, 60)

    -- background widget
    local bw = awful.wibar({
      position  = "left",
      screen    = s,
      ontop     = false,
      type      = "dock",
      visible   = true,
      width     = w,
      height    = h,
      x         = x,
      y         = y,
      shape     = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, radius)
                  end,
      bg        = beautiful.colors.black2,
      margins   = {
        left = dpi(margin)
      }
    })

    local header = block.new(
    nil,
    {
      profile,
      nil,
      layout = wibox.layout.align.horizontal
    })

    bw:setup{
      layout = wibox.layout.align.vertical,
      header,
    }

    s.bw = bw
end


return M
