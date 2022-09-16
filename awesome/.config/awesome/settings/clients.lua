local awful = require("awful")
local wibox = require("wibox")
local theme = require("theme")

local M = {}

local function enable_shadow(c)
    awful.spawn("xprop -id " .. c .. " -f _COMPTON_SHADOW 32c -set _COMPTON_SHADOW 1", false)
end

local function disable_shadow(c)
    awful.spawn("xprop -id " .. c .. " -f _COMPTON_SHADOW 32c -set _COMPTON_SHADOW 0", false)
end

local function special_shadowing(c)
    local s = c.screen
    local layout = s.selected_tag.layout.name

    -- only implement shadows for floating and not maximized windows
    if layout == 'floating' or
       c.floating and
       not c.maximized then
        enable_shadow(c.window)
    else
        disable_shadow(c.window)
    end
end

function M.setup()
    local titlebar = require("interface.titlebar")
    local titlebar_size = theme.titlebar_size

    -- titlebar hook
    client.connect_signal("request::titlebars",
    function(c)
        titlebar.setup(c)
    end)

    -- focus client hook
    client.connect_signal("focus",
    function(c)  -- when client gains focus
        if c.sticky then
            c.border_color = beautiful.border_sticky
        else
            c.border_color = beautiful.border_focus
        end
    end)

    -- unfocus client hook
    client.connect_signal("unfocus",
    function(c) -- when clients loses focus
        if c.sticky then
            c.border_color = beautiful.border_sticky_unfocus
        else
            c.border_color = beautiful.border_normal
        end
    end)

    -- manage hook, when a new client appears and gets managed by wm
    client.connect_signal("manage",
    function(c)
        -- Set the windows at the slave,
        if awesome.startup
          and not c.size_hints.user_position
          and not c.size_hints.program_position then
            awful.placement.no_offscreen(c) -- Prevent clients from being unreachable after screen count changes.
        end

        if c.floating then
            awful.placement.centered(c)
            c.ontop = true
        end
    end)

    -- arrange hook, when layout is being placed out
    screen.connect_signal("arrange",
    function (s)
        for _, c in pairs(s.clients) do -- loop through clients
            -- terminal windows have titlebars only on floating
            -- c.class == terminal_class
            -- awful.titlebar.show(c)
            awful.titlebar.hide(c)
        end
    end)
end

return M
