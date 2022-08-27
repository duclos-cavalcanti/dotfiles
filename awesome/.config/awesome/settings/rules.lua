local gears = require("gears")
local awful = require("awful")

local M = {}

function M.setup(keys)
    -- Rules
    awful.rules.rules = {
        -- All clients
       {
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

       {
            rule = {
                class = "Firefox"
            },
            properties = {
                maximized = false
            }
        },

       {
            rule = {
                class = "Xephyr"
            },
            properties = {
               floating = false
            }
        },

        -- Floating clients.
        {
            rule_any = {
                instance = {
                    "scratch",
                },
                class = {
                    "Arandr",
                    "Blueman-manager",
                    "Gcolor3",
                    "Galculator",
                    "Places", -- Firefox Library
                    "Sxiv",
                    "Lxappearance",
                    "Pcmanfm",
                    "Nitrogen",
                    "Nm-connection-editor",
                    "Wpg",
                    "Pavucontrol"
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
            }
      },

      -- Sticky and Floating
      {
          rule = {
              class = "Spotify"
          },
          properties = {
              sticky = true,
              floating = true,
          }
      },

      -- Add titlebars to normal clients and dialogs
      {
          rule_any = {
              type = { "normal", "dialog" }
          },
          properties = {
              titlebars_enabled = true
          }
      },

       -- Honor these applications
       {
           rule_any = {
               name = {
                   "Game",
               }
           },
           properties = {
               placement = awful.placement.centered,
               size_hints_honor = true ,
               floating = true
           }
       },

        -- Tag specific applications
        {
            rule = {
                class = "email"
            },
            properties = {
                screen = 1,
                tag = "9"
            }
        },
    }
end

return M
