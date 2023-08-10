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
        { -- make these floating
            rule_any = {
                instance = {
                    "scratch",
                    "Library"
                },
                class = {
                    "Arandr", -- xrandr/display manager
                    "Nm-connection-editor", -- network manager
                    "Blueman-manager", -- bluetooth manager
                    "Nautilus", -- filemanager
                    "Nitrogen", -- wallpaper utility
                    "Gcolor3", -- color picker/utility
                    "Galculator",
                    "Gpick", -- color picker
                    "Gedit", -- gnome gui editor
                    "Weather",
                    "Pavucontrol", -- media utility
                    "xfce4-power-manager-settings", -- xfce power manager
                    "Baobab", -- disk utility
                    "Mainwindow.py", -- class for playonlinux
                    "Pidgin",
                    "Eog", -- image viewer
                    "Totem", -- videos
                    "Eduvpn-gui", -- vpn
                    "Xephyr"
                },
                name = {
                    "Event Tester",  -- xev.
                    "Compose Message", -- email
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
        { -- floating window for games
            rule_any = {
                class = {
                    "Wine",
                    "mtga.exe",
                },
                role = {
                    "pop-up",
                }
            },
            properties = {
                floating = true,
                placement = awful.placement.centered,
                honor_workarea = false,
                honor_padding = false,
                size_hints_honor = false,
                maximized = false,
                ontop = true,
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
        { -- add titlebars to normal clients and dialogs
          rule_any = {
              type = { "normal", "dialog" }
          },
          properties = {
              titlebars_enabled = true
          }
        },
        { -- force these clients maximized property to false
           rule = {
                "Firefox",
           },
           properties = {
               maximized = false
           }
        },
    }
end

return M
