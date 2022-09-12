local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local M = {}

-- tasklist buttons
local tasklist_buttons = awful.util.table.join(
  awful.button({ }, 1,
    function(c)
      if c == client.focus then
          c.minimized = true
      else
        c.minimized = false
        if not c:isvisible() and c.first_tag then
          c.first_tag:view_only()
        end
        client.focus = c
        c:raise()
      end
    end
  ),
  awful.button({ }, 3, nil)
)


local function create_callback(self, c)
    local tb = self:get_children_by_id('text_role')[1]
    local set_markup_silently = tb.set_markup_silently

    -- self and current text
    tb.set_markup_silently = function(slf, text)
        local new_text = c.class
        if c.sticky then
            new_text = new_text .. " -- Sticky"
        end
        return set_markup_silently(tb, new_text)
    end
end

function M.default(s)
    return awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout  = {
          spacing   = dpi(1),
          layout    = wibox.layout.flex.horizontal
        },
        widget_template = {
                {
                    {
                        {
                            id      = 'icon_role',
                            widget  = wibox.widget.imagebox,
                        },
                        left    = dpi(2),
                        margins = 1,
                        widget  = wibox.container.margin,
                    },
                    {
                        {
                            id     = 'text_role',
                            widget = wibox.widget.textbox,
                        },
                        id      = 'text_margin_role',
                        left    = dpi(2),
                        right   = dpi(6),
                        widget  = wibox.container.margin,
                    },
                    layout  = wibox.layout.fixed.horizontal,
                },
                id     = 'background_role',
                widget = wibox.container.background,
                create_callback = create_callback,
        },
    }
end

return M
