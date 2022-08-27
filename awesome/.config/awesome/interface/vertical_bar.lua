local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local M = {}

function M.setup(s)
    bar_width = bar_height

    local function task(scr)
        return awful.widget.tasklist {
            screen = scr,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = gears.table.join(
                        awful.button({}, 1,
                        function (c) -- left click
                            if c == client.focus then
                              c.minimized = true
                            else
                              c:emit_signal("request::activate", "tasklist", {raise = true})
                            end
                        end)),
            layout = {
              spacing = dpi(5),
              layout = wibox.layout.flex.vertical
            },
            widget_template = {
                {
                    {
                        id = 'clienticon',
                        widget = awful.widget.clienticon,
                    },
                    margins = dpi(0),
                    widget = wibox.container.margin,
                },
                wibox.widget.base.make_widget(),
                id              = 'background_role',
                shape           = function(cr, width, height)
                                    gears.shape.rounded_rect(cr, width, height, 2)
                                  end,
                widget          = wibox.container.background,
                create_callback = function(self, c)
                                    self:get_children_by_id('clienticon')[1].client = c
                                  end,
            }
          }
    end

    local function separator()
        return wibox.widget {
            {
                forced_height = dpi(2),
                shape   = gears.shape.line,
                widget  = wibox.widget.separator,
            },
            top = dpi(10),
            left = dpi(5),
            right = dpi(5),
            bottom = dpi(10),
            widget = wibox.container.margin
        }
    end

    local bar = awful.wibar({
      position  = "left",
      bg        = beautiful.colors.bg,
      fg        = beautiful.colors.fg,
      width     = bar_width,
      height    = s.geometry.height - bar_height,
      screen    = s,
    })

    bar:setup{
      layout = wibox.layout.align.vertical,
      { -- top
        {
            task(s),
            layout = wibox.layout.fixed.vertical,
        },
        left = dpi(5),
        right = dpi(5),
        top = dpi(10),
        widget = wibox.container.margin,
      },
      { -- middle
        layout = wibox.layout.fixed.vertical,
      },
      { -- bottom
        wibox.widget{
            {
                {
                    {
                        separator(),
                        spacing = dpi(20),
                        layout = wibox.layout.fixed.vertical,
                    },
                    separator(),
                    layout = wibox.layout.fixed.vertical,
                },
                left = dpi(2),
                right = dpi(2),
                bottom = dpi(10),
                top = dpi(10),
                widget = wibox.container.margin
            },
            shape  = function(cr, width, height)
                     gears.shape.rounded_rect(cr, width, height, 2)
                   end,
            widget = wibox.container.background,
        },
        left = dpi(5),
        right = dpi(5),
        bottom = dpi(10),
        widget = wibox.container.margin,
      },
      }

    s.vertical_bar = bar
end


return M
