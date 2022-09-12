local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local M = {}

function M.set_bar(s)
    -- Menu Launcher
    local function menu_launcher()
        return require("interface.widgets.menu").default()
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
        return require("interface.widgets.taglist").circular(scr, 8)
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

    -- separator
    local function separator()
        return require("interface.widgets.separator").default(bar_height)
    end

    s.launcher  = menu_launcher()
    s.keyboard  = keyboard()
    s.clock     = clock()
    s.taglist   = taglist(s)
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
        }

    if s.index == 1 then
       table.insert(_right, s.separator)
       table.insert(_right, s.systray)
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
