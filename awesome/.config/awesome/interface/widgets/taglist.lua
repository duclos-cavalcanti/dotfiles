local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local M = {}

-- taglist buttons
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )


function M.default(s)
    return awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons,
    }
end

function M.circular(s, radius)
    local function create_callback(self, c3, index, objects)
    end

    return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style = {
            shape = function(cr, width, height)
                gears.shape.circle(cr, width, height, radius, 0)
            end,
        },
        widget_template = {
            {
                {
                  id = "text_role",
                  widget = wibox.widget.textbox,
                },
                left = 4,
                right = 4,
                widget = wibox.container.margin,
            },
                id = "background_role",
                widget = wibox.container.background,
                create_callback = create_callback,
        },
    }
end

function M.custom(s)
    local function update_tag(item, tag, index)
        if tag.selected then
            item:get_children_by_id("tag")[1].markup = "<span foreground='"..beautiful.taglist_fg_focus.."'>◆</span>"
        elseif #tag:clients() > 0 then
            item:get_children_by_id("tag")[1].markup = "<span foreground='"..beautiful.taglist_fg_occupied.."'>◇</span>"
        else
            item:get_children_by_id("tag")[1].markup = "<span foreground='"..beautiful.taglist_fg_empty.."'>◇</span>"
        end
    end

    return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        layout   = {
    	    spacing = dpi(10),
    	    layout = wibox.layout.fixed.horizontal,
        },
        style = {
            spacing = dpi(5)
        },
        widget_template = {
    	    id = "tag",
    	    font = beautiful.font_tags,
    	    widget = wibox.widget.textbox,
    	    create_callback = function(self, c3, index, object)
    	    	update_tag(self, c3, index)
    	    end,

    	    update_callback = function(self, c3, index, object)
    	    	update_tag(self, c3, index)
    	    end
        },
    }
end

return M
