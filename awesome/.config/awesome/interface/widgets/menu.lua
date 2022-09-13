local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local hotkeys_popup = require("awful.hotkeys_popup")

local M = {}

local menu =  {
      w = awful.menu({
          items = {
                    {
                        "awesome",
                        {
                            { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
                            { "edit config", terminal .. " " .. awesome.conffile },
                            { "restart", awesome.restart },
                            { "quit", function() awesome.quit() end }
                        },
                    },
                    { "terminal", terminal }
        }
    })
}

function M.default()
    return awful.widget.launcher({
        image = beautiful.menu_icon,
        menu = menu.w,
    })
end

function M.rounded(radius)
    local w = awful.widget.launcher({
        image = beautiful.menu_icon,
        menu = menu.w,
    })

    return wibox.widget {
      bg = beautiful.colors.bg,
      fg = beautiful.colors.fg,
      shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
      end,
      widget = wibox.container.background,
      {
          {
              {
                  widget = w,
              },
              left = 2,
              right = 2,
              top = 2,
              bottom = 2,
              widget = wibox.container.margin,
          },
      layout = wibox.layout.fixed.horizontal,
      },
    }
end

return M
