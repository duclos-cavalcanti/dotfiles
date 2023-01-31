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

function M.custom(s)
    local update_tags = function(self, c3, index)
        local tagicon = self:get_children_by_id('icon_role')[1]
        tagicon.markup = string.format("<span font_desc='%s'>%d</span>", beautiful.font_icon, index)
        if c3.selected then
        	-- tagicon.text = ""
        	self.bg = beautiful.taglist_bg_focus
        	self.fg = beautiful.taglist_fg_focus
        elseif #c3:clients() == 0 then
        	-- tagicon.text = ""
        	self.bg = beautiful.taglist_bg_empty
        	self.fg = beautiful.taglist_fg_empty
        else
        	-- tagicon.text = ""
        	self.bg = beautiful.taglist_bg_occupied
        	self.fg = beautiful.taglist_fg_occupied
        end
    end
    return awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            layout = { spacing = 0, layout = wibox.layout.fixed.horizontal },
		    widget_template = {
			    {
			    	{
                        id = 'icon_role',
                        font = beautiful.font_icon, widget = wibox.widget.textbox
                    },
			    	id = 'margin_role',
			    	top = dpi(0),
			    	bottom = dpi(0),
			    	left = dpi(4),
			    	right = dpi(4),
			    	widget = wibox.container.margin
			    },
			    id = 'background_role',
			    widget = wibox.container.background,
			    create_callback = function(self, c3, index, objects)
			    	update_tags(self, c3, index)
			    end,
			    update_callback = function(self, c3, index, objects)
			    	update_tags(self, c3, index)
			    end
		    },
		    buttons = taglist_buttons
    }
end

return M
