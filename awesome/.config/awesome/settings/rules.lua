local gears = require("gears")
local awful = require("awful")

local M = {}

function M.setup(keys)
    -- Rules
    awful.rules.rules = {
        { -- base properties to all clients
            rule = { },
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = keys.clientkeys,
                buttons = keys.mousekeys,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap+awful.placement.no_offscreen
            }
        },
        { -- add titlebars to normal clients and dialogs
          rule_any = {
              type = { "normal", "dialog" }
          },
          properties = {
              titlebars_enabled = true
          }
        },
        { -- make these floating
            rule_any = {
                instance = {
                    "scratch",
                    "Library"
                },
                class = {
                    "Arandr",
                    "Blueman-manager",
                    "Nautilus",
                    "Nitrogen",
                    "Gcolor3",
                    "Galculator",
                    "Gpick",
                    "Gedit",
                    "Weather",
                    "Pavucontrol",
                    "Baobab",
                    "Pidgin",
                    "Eog",
                    "Totem",
                    "Xephyr"
                },
                name = {
                    "Event Tester",  -- xev.
                },
                role = {
                    "pop-up",
                }
            },
            properties = {
                floating = true,
                placement = awful.placement.centered,
                ontop = true,
            }
        },
        { -- force maximized to false
           rule = {
               class = {
                "Firefox",
                "Spotify"
               }
           },
           properties = {
               maximized = false
           }
        },
        { -- force all floating to be centered and ontop!
            rule = {
                floating = true,
            },
            properties = {
                placement = awful.placement.centered,
                ontop = true,
            }
        },
    }
end

return M
