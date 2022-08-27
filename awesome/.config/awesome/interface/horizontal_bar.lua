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
    -- Keyboard indicator
    local function menu_launcher()
        local menu = require("interface.menu").main_menu

        return awful.widget.launcher({
            image = beautiful.menu_icon,
            bg = colors.white,
            menu = menu
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
            prompt = " ➜ ",
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
    -- local function tasklist(scr)
    --     return awful.widget.tasklist({
    --         screen = scr,
    --         filter = awful.widget.tasklist.filter.currenttags,
    --         buttons = tasklist_buttons,
    --         style = {
    --             tasklist_disable_icon = true,
    --             },
    --         })
    -- end

    local function tasklist(scr)
        return awful.widget.tasklist {
            screen = scr,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons,
            layout = {
              spacing = dpi(0),
              layout = wibox.layout.flex.horizontal
            },
            widget_template = {
                {
                    {
                        id = 'clienticon',
                        widget = awful.widget.clienticon,
                    },
                    margins = dpi(1),
                    widget = wibox.container.margin,
                },
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

    -- Systray
    local function systray()
        local w = wibox.widget.systray()
        w.base_size = beautiful.systray_icon_size

        return w
    end

    local function space()
        local sp = wibox.widget.textbox()
        sp:set_text(" ")
        return sp
    end

    -- separator
    local function separator()
        local style = {
            margin = { 0, 0, 0, 0},
		    color  = {
                shadow1 = beautiful.separator_bg1,
                shadow2 = beautiful.separator_bg2,
                }
            }

        local w = wibox.widget.base.make_widget()

        function w:fit(_, _, height)
            return 2 + style.margin[1] + style.margin[2], height
        end

        function w:draw(_, cr, _, height)
		    local h = height - style.margin[3] - style.margin[4]

		    cr:translate(style.margin[1], style.margin[3])
		    cr:set_source(gears.color(style.color.shadow1))
		    cr:rectangle(0, 0, 1, h)
		    cr:fill()

		    cr:set_source(gears.color(style.color.shadow2))
		    cr:rectangle(1, 0, 1, h)
		    cr:fill()
        end

        return w
    end

    s.launcher = menu_launcher()
    s.clock = clock()
    s.taglist = taglist()
    s.tasklist_ = tasklist(s)
    s.promptbox = promptbox()
    s.layoutbox = layoutbox(s)
    s.systray = systray()
    s.separator = separator()

    -- Create the wibox/wibar
    s.wibox = awful.wibar({
        position = "top",
        height = bar_height,
        screen = s
    })

    s.wibox:setup {
        layout = wibox.layout.align.horizontal,
        -- Left widgets
        {
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
            s.promptbox,
        },

        -- Middle widgets
        -- s.tasklist_,
        {
            s.tasklist_,
            layout = wibox.layout.fixed.horizontal,
        },

        -- Right widgets
        {
            layout = wibox.layout.fixed.horizontal,
            s.clock,
            s.systray,
        },
    }
end

function M.setup(s)
    M.set_bar(s)
end


return M
