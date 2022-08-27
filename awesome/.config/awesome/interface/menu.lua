local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

return {
      main_menu = awful.menu({
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
