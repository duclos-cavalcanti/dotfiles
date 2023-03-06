local gears = require("gears")
local awful = require("awful")

local M = {}

function M.setup(keys)
    -- Rules
    awful.rules.rules = {
        { -- All clients
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
        { -- Floating clients.
            rule_any = {
                instance = {
                    "scratch",
                    "Library"
                },
                class = {
                    "Arandr",
                    "Blueman-manager",
                    "Pcmanfm",
                    "Nitrogen",
                    "Gcolor3",
                    "Galculator",
                    "Gpick",
                    "Pavucontrol",
                    "Baobab",
                    "Sxiv",
                    "Mpv",
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
      -- force all floating windows to be centered and ontop!
      -- finally was able to do this, since floating windows
      -- were popping up in random locations
      {
          rule = {
              floating = true,
          },
          properties = {
              placement = awful.placement.centered,
              ontop = true,
          }
      },

      { -- browser
           rule = {
               class = "Firefox"
           },
           properties = {
               maximized = false
           }
       },

       { -- popup videos from browser
            rule = {
                name = "Picture-in-Picture"
            },
            properties = {
                sticky = true,
                skip_taskbar = true,
                ontop = true,
                placement = awful.placement.bottom_right
            }
        },
        { -- xorg server emulator
            rule = {
                class = "Xephyr"
            },
            properties = {
               floating = true
            }
        },
        { -- Add titlebars to normal clients and dialogs
          rule_any = {
              type = { "normal", "dialog" }
          },
          properties = {
              titlebars_enabled = true
          }
        },
    }
end

return M
