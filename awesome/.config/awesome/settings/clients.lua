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

    -- titlebar hook
    client.connect_signal("request::titlebars",
    function(c)
        titlebar.setup(c)
    end)

    -- focus client hook
    client.connect_signal("focus",
    function(c)  -- when client gains focus
        c.border_color = beautiful.border_focus
    end)

    -- unfocus client hook
    client.connect_signal("unfocus",
    function(c) -- when clients loses focus
        if c.sticky then
            c.border_color = beautiful.border_sticky
        else
            c.border_color = beautiful.border_normal
        end
    end)

    -- manage hook, when a new client appears and gets managed by wm
    client.connect_signal("manage",
    function(c)
        if awesome.startup and
           not c.size_hints.user_position and
           not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end

        -- only implement shadowing for floating and not maximized windows
        -- this prevents shadowing over the bars when bars on the bottom
        -- of screen
        special_shadowing(c)

        -- Some applications do not respect ICCCM rules correctly
        -- and redefine the window class property.
        c:connect_signal("property::class", awful.rules.apply)
        awful.rules.apply(c)
    end)

    client.connect_signal("unmanage", function (c)
        if c.class == "Spotify" then
            c:disconnect_signal("property::class", awful.rules.apply)
        end
    end)

    -- arrange hook, when layout is being placed out
    screen.connect_signal("arrange",
    function (s) end)
end

return M
