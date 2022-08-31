local wibox = require("wibox")
local gears = require("gears")
local dpi   = require("beautiful").xresources.apply_dpi
local theme = require("theme")
local utils = require("utils")

local M = {
  picture = function(shape)
    return wibox.widget({
        image      = theme.arch_icon,
        widget     = wibox.widget.imagebox,
        clip_shape = shape
    })
  end,

  name = function(size)
    return wibox.widget{
        id            = "profile",
        text          = utils.user(),
        align         = "center",
        opacity       = 1,
        font          = theme.font_family .. " Bold " .. size,
        widget        = wibox.widget.textbox,
    }
  end
}

function M.new(width, height)
    return wibox.widget({
        {
          M.picture(gears.shape.circle),
          {
            M.name(12),
            widget = wibox.container.margin,
            left   = dpi(5)
          },
          layout = wibox.layout.fixed.horizontal
        },
        widget          = wibox.container.background,
        bg              = beautiful.colors.black,
        forced_width    = dpi(width),
        forced_height   = dpi(height),
    })
end

return M
