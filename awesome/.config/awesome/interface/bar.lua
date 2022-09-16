local awful = require("awful")
local vicious = require("vicious")
local gears = require("gears")
local wibox = require("wibox")

local dpi = require("beautiful.xresources").apply_dpi

local M = {}

function M.set_bar(s)
    local radius = 4
    local margin = 2

    -- Menu Launcher
    local function menu_launcher()
        return require("interface.widgets.menu").rounded(radius)
    end

    -- Keyboard indicator
    local function keyboard()
        return require("interface.widgets.keyboard").default()
    end

    -- Clock
    local function clock()
        return require("interface.widgets.clock").default()
    end

    -- Run Prompt
    local function promptbox()
        return require("interface.widgets.prompt").default()
    end

    -- Layoutbox
    local function layoutbox(scr)
        return require("interface.widgets.layout").default(scr)
    end

    -- Taglist
    local function taglist(scr)
        return require("interface.widgets.taglist").default(scr)
    end

    -- Tasklist
    local function tasklist(scr)
        return require("interface.widgets.tasklist").default(scr)
    end

    -- Systray
    local function systray()
        return require("interface.widgets.tray").default()
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

    local function cpu()
        return require("interface.widgets.cpu"){
            background_color = beautiful.colors.wm.bar.bg,
            color = beautiful.colors.fg,
        }
    end

    local function ram()
        return require("interface.widgets.ram"){
            color_used = beautiful.colors.green2,
            color_free = beautiful.colors.green,
            color_buf = beautiful.colors.yellow,
            widget_show_buf = true,
            widget_height = bar_height + 1
        }
    end

    local function separator()
        return require("interface.widgets.separator").default(bar_height)
    end


    s.promptbox = promptbox()

    local _left = {
            layout = wibox.layout.fixed.horizontal,
            space(),
            menu_launcher(),
            space(),
            separator(),
            space(),
            taglist(s),
            space(),
            separator(),
            space(),
            s.promptbox,
        }

    -- local _middle = {
    --     layout = wibox.layout.fixed.horizontal,
    --     halign = "center",
    --     tasklist(s)
    -- }

    local _middle = tasklist(s)

    local _right = {
            layout = wibox.layout.fixed.horizontal,
            space(),
            separator(),
            space(),
            layoutbox(s),
            space(),
            separator(),
            space(),
            clock(),
        }

    if s.index == 1 then -- primary
       table.insert(_right,space())
       table.insert(_right,separator())
       table.insert(_right,space())
       table.insert(_right, systray())
    end

    -- Create the wibox/wibar
    s.wibox = awful.wibar({
        position = "top",
        height = bar_height,
        screen = s,
        bg = beautiful.wibar_bg,
    })

    -- https://awesomewm.org/doc/api/documentation/03-declarative-layout.md.html
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
