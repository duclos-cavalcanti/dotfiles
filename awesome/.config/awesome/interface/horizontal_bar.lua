local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local M = {}

local function widget_wrapper(w)
    return {
        w,
        top = dpi(5),
        left = dpi(5),
        bottom = dpi(5),
        right = dpi(5),
        widget = wibox.container.margin
    }
end

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


function M.set_bar(s)
    -- menu launcher
    local function menu_launcher()
        local menu = require("interface.menu").main_menu

        return awful.widget.launcher({
            image = beautiful.menu_icon,
            menu = menu,
        })
    end

    -- Keyboard indicator
    local function keyboard()
        return awful.widget.keyboardlayout()
    end

    -- Clock
    local function clock()
        return wibox.widget.textclock()
    end

    -- Run Prompt
    local function promptbox()
        return awful.widget.prompt({
            prompt = beautiful.prompt_prefix,
        })
    end

    -- Layoutbox
    local function layoutbox(scr)
        return awful.widget.layoutbox(scr)
    end

    -- Taglist
    local function taglist()
        return awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons
        }
    end

    -- Tasklist
    local function tasklist(scr)
        return awful.widget.tasklist {
            screen  = scr,
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
                    create_callback = function(self, c)
                        local tb = self:get_children_by_id('text_role')[1]
                        local set_markup_silently = tb.set_markup_silently
                        tb.set_markup_silently =
                        function(slf, text) -- self and current text
                            local new_text = c.class
                            if c.sticky then
                                new_text = new_text .. " -- Sticky"
                            end
                            return set_markup_silently(tb, new_text)
                        end
                    end,
            },
        }
    end

    -- Systray
    local function systray()
        local w = wibox.widget.systray()
        w.base_size = beautiful.systray_icon_size

        return w
    end

    local function tab()
        local sp = wibox.widget.textbox()
        sp:set_text("   ")
        return sp
    end

    local function space()
        local sp = wibox.widget.textbox()
        sp:set_text(" ")
        return sp
    end

    -- separator
    local function separator()
        return wibox.widget {
            {
               forced_width     = 1,
               forced_height    = bar_height - 5,
               thickness        = 1,
               border_width     = 2,
               color            = beautiful.separator_fg,
               widget           = wibox.widget.separator
             },
             valign = 'center',
             halign = 'center',
             widget = wibox.container.place
        }
    end

    s.launcher  = menu_launcher()
    s.keyboard  = keyboard()
    s.clock     = clock()
    s.taglist   = taglist()
    s.tasklist_ = tasklist(s)
    s.promptbox = promptbox()
    s.layoutbox = layoutbox(s)
    s.systray   = systray()
    s.separator = separator()

    -- Create the wibox/wibar
    s.wibox = awful.wibar({
        position = "top",
        height = bar_height,
        screen = s
    })

    local _left = {
            layout = wibox.layout.fixed.horizontal,
            s.launcher,
            s.separator,
            s.taglist,
            space(),
            s.separator,
            space(),
            s.layoutbox,
            space(),
            s.separator,
            space(),
            s.promptbox,
        }

    local _middle = s.tasklist_
    -- local _middle = {
    --     layout = wibox.layout.align.horizontal,
    --     s.tasklist_
    -- }

    local _right = {
            layout = wibox.layout.fixed.horizontal,
            s.clock,
            s.separator,
            s.keyboard,
            s.separator,
            s.systray,
        }

    if s.index == 1 then
       table.insert(_right, tab())
    end

    s.wibox:setup {
        layout = wibox.layout.align.horizontal,
        _left,
        _middle,
        _right,
    }
end

function M.setup(s)
    M.set_bar(s)
end


return M
