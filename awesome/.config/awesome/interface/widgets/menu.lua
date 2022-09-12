local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local M = {}

local menu =  {
      w = awful.menu({
          items = {
                    {
                        "awesome",
                        {
                            { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
                            { "edit config", terminal .. " " .. awesome.conffile },
                            { "restart", awesome.restart },
                            { "quit", function() awesome.quit() end }
                        },
                    },
                    { "terminal", terminal }
        }
    })
}

function M.default()
    return awful.widget.launcher({
        image = beautiful.menu_icon,
        menu = menu.w,
    })
end

return M
