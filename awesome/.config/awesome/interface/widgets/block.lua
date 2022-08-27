local gears = require("gears")
local wibox = require("wibox")
local dpi   = require("beautiful").xresources.apply_dpi
local theme = require("theme")

local function make_margin(content, margin)
    return {
        content,
        widget  = wibox.container.margin,
        margins = margin or dpi(10),
    }
end

local M = {}

function M.new(header, content, margin)
    if header == nil then
        return wibox.widget(
            make_margin({
                make_margin(content, margin),
                widget = wibox.container.background,
                bg = theme.colors.bg,
            },
            margin)
        )
    else
        return wibox.widget(
        make_margin({
            {
              { -- header name
                  markup   = "<span foreground='" .. beautiful.fg_focus .."'>" .. header .."</span>",
                  font     = theme.font_family .. '14',
                  align    = "center",
                  opacity  = 1,
                  widget   = wibox.widget.textbox,
              },
              shape  =  function(cr, width, height)
                            gears.shape.partially_rounded_rect(cr, width, height, 5)
                        end,
              widget = wibox.container.background,
              bg     = theme.colors.black,
            },
            {
              make_margin(content, margin),
              shape  =  function(cr, width, height)
                            gears.shape.partially_rounded_rect(cr, width, height, 5)
                        end,
              widget = wibox.container.background,
              bg     = theme.colors.black2,
            },
            layout = wibox.layout.align.vertical
        },
        margin)
        )
    end
end

return M
