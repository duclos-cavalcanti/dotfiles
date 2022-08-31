local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

local menu = require("interface.menu")

local M = {}

M.globalkeys = {}
M.mousekeys = {}
M.clientkeys = {}

function M.set_mouse_bindings()
    root.buttons(gears.table.join(
        awful.button({ }, 3, function () print("Pressed right click on root window!") end)
    ))

    M.mousekeys = gears.table.join(
        awful.button({ }, 1, function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end),
        awful.button({ modkey }, 1, function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ modkey }, 3, function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )
end

function M.set_keybindings()
        -- tags
        M.globalkeys = gears.table.join(M.globalkeys,
        awful.key({ M.modkey }, "b",
                  awful.tag.viewprev,
                  {
                      "go to previous tag",
                      "workspace"
                  }),
        awful.key({ M.modkey }, "n",
                  awful.tag.viewnext,
                  {
                      "go to next tag",
                      "workspace"
                  }),
        awful.key({ M.modkey }, "p",
                  awful.tag.history.restore,
                  {
                      "go to last visited tag",
                      "workspace"
                  }),

        -- screens
        awful.key({ M.modkey, "Control" }, "l",
                  function () awful.screen.focus_bydirection("right") end,
                  {
                      "focus screen to the right",
                      "screen"
                  }),
        awful.key({ M.modkey, "Control" }, "h",
                  function () awful.screen.focus_bydirection("left") end,
                  {
                      "focus screen to the left",
                      "screen"
                  }),

        -- clients/windows
        awful.key({ M.modkey }, "Tab",
                      function()
                        awful.client.focus.byidx(1)
                    end,
                  {
                      "cycle to next client",
                      "client"
                  }),
        awful.key({ M.modkey, "Shift" }, "Tab",
                  function()
                      awful.client.focus.byidx(-1)
                  end,
                  {
                      "cycle to previous client",
                      "client"
                  }),
        awful.key({ M.modkey }, "h",
                  function() awful.client.focus.bydirection("left") end,
                  {
                      "focus client to the left",
                      "client"
                  }),
        awful.key({ M.modkey }, "j",
                  function() awful.client.focus.bydirection("down") end,
                  {
                      "focus client below",
                      "client"
                  }),
        awful.key({ M.modkey }, "k",
                  function() awful.client.focus.bydirection("up") end,
                  {
                      "focus client above",
                      "client"
                  }),
        awful.key({ M.modkey }, "l",
                  function() awful.client.focus.bydirection("right") end,
                  {
                      "focus client to the right",
                      "client"
                  }),
        awful.key({ M.modkey, "Shift" }, "h",
                  function() awful.client.swap.bydirection("left") end,
                  {
                      "move client to the left",
                      "client"
                  }),
        awful.key({ M.modkey, "Shift" }, "j",
                  function() awful.client.swap.bydirection("down") end,
                  {
                      "move client down",
                      "client"
                  }),
        awful.key({ M.modkey, "Shift" }, "k",
                  function() awful.client.swap.bydirection("up") end,
                  {
                      "move client up",
                      "client"
                  }),
        awful.key({ M.modkey, "Shift" }, "l",
                  function() awful.client.swap.bydirection("right") end,
                  {
                      "move client to the right",
                      "client"
                  }),

        -- layouts
        awful.key({ M.modkey }, "Right",
                  function() awful.layout.inc(1) end,
                  {
                      "cycle layout +1",
                      "layout"
                  }),
        awful.key({ M.modkey }, "Left",
                  function() awful.layout.inc(-1) end,
                  {
                      "cycle layout -1",
                      "layout"
                  }),
        awful.key({ M.modkey }, "t",
                  function() awful.layout.set(awful.layout.suit.tile) end,
                  {
                      "change to tile layout",
                      "layout"
                  }),
        awful.key({ M.modkey }, "m",
                  function()
                    local s = awful.screen.focused()
                    local lay = s.selected_tag.layout_name
                    if lay ~= "max" then
                        awful.layout.set(awful.layout.suit.max)
                    end
                  end,
                  {
                      "change to max layout",
                      "layout"
                  }),

        -- launch programs
        awful.key({ M.modkey }, "Return",
                  function() awful.spawn(terminal) end,
                  {
                      "spawn terminal",
                      "applications"
                  }),
        awful.key({ M.modkey, "Shift" }, "Return",
                  function() awful.spawn(terminal .. " --class scratch", {placement = awful.placement.center}) end,
                  {
                      "spawn floating terminal",
                      "applications"
                  }),
        awful.key({ M.modkey }, "i",
                  function() awful.spawn("firefox") end,
                  {
                      "spawn firefox",
                      "applications"
                  }),
        awful.key({ M.modkey }, "space",
                  function() awful.screen.focused().promptbox:run() end,
                  {
                      "spawn awesome prompt",
                      "applications"
                  }),

        -- awesome shortcuts
        awful.key({ M.modkey, "Control" }, "r",
                  awesome.restart,
                  {
                      "restart awesome",
                      "awesome"
                  }),
        awful.key({ M.modkey, "Control" }, "q",
                  awesome.quit,
                  {
                      "quit awesome",
                      "awesome"
                  })
        )
end

function M.set_tags_bindings()
    local first = 1
    local last = #taglist
    for i = first, last do
        if i == 10 then
            i = 1
        end
        M.globalkeys = gears.table.join(M.globalkeys,
            -- View tag only.
            awful.key({ M.modkey }, "#" .. i + #taglist,
                      function ()
                            local screen = awful.screen.focused()
                            local tag = screen.tags[i]
                            if tag then
                               tag:view_only()
                            end
                      end,
                      {description = "view tag #"..i, group = "workspace"}),
            -- Toggle tag display.
            awful.key({ M.modkey, "Control" }, "#" .. i + #taglist,
                      function ()
                          local screen = awful.screen.focused()
                          local tag = screen.tags[i]
                          if tag then
                             awful.tag.viewtoggle(tag)
                          end
                      end,
                      {description = "toggle tag #" .. i, group = "workspace"}),
            -- Move client to tag.
            awful.key({ M.modkey, "Shift" }, "#" .. i + #taglist,
                      function ()
                          if client.focus then
                              local tag = client.focus.screen.tags[i]
                              if tag then
                                  client.focus:move_to_tag(tag)
                              end
                         end
                      end,
                      {description = "move focused client to tag #"..i, group = "workspace"}),
            -- Toggle tag on focused client.
            awful.key({ M.modkey, "Control", "Shift" }, "#" .. i + #taglist,
                      function ()
                          if client.focus then
                              local tag = client.focus.screen.tags[i]
                              if tag then
                                  client.focus:toggle_tag(tag)
                              end
                          end
                      end,
                      {description = "toggle focused client on tag #" .. i, group = "workspace"})
        )
    end
end

function M.set_client_keybindings()
    M.clientkeys = gears.table.join(M.clientkeys,
    -- handle/move clients
    awful.key({ M.modkey }, "w",
              function (c) c:kill() end,
              {
                  "kill client",
                  "client"
              }),
    awful.key({ M.modkey }, "o",
              function(c) c:move_to_screen() end,
              {
                  "move client to next screen",
                  "client"
              }),
    awful.key({ M.modkey }, "minus",
              function (c) c.minimized = true end,
              {
                  "minimize client",
                  "client"
              }),
    awful.key({ M.modkey }, "equal",
              function (c)
                print("Equal")
                local s = c.screen
                for _, client in pairs(s.clients) do
                    if client.minimized then
                        client.minimized = not client.minimized
                        client:raise()
                        break
                    end
                end
              end,
              {
                  "unminimize client",
                  "client"
              }),

    -- client layout
    awful.key({ M.modkey, "Shift" }, "m",
              function (c)
                c.maximized = not c.maximized
                c:raise()
              end,
              {
                  "maximize client",
                  "client"
              }),
    awful.key({ M.modkey, "Shift" }, "f",
              function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
              end,
              {
                  "make client fullscreen",
                  "client"
              }),
    awful.key({ M.modkey }, "s",
              function (c)
                c.sticky = not c.sticky
                c:raise()
              end,
              {
                  "make client sticky",
                  "client"
              }),
    awful.key({ M.modkey }, "f",
              awful.client.floating.toggle,
              {
                  "float client",
                  "client"
              })
    )
end

function M.set_ignored_bindings()
    -- ignore mouse roll
    awful.button.ignored_modifiers = {"Lock", "Mod2", "4", "5"}
end

function M.setup()
    M.modkey = modkey
    M.altkey = altkey

    -- mouse-enter hook
    client.connect_signal("mouse::enter", function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end)

    M.set_mouse_bindings()
    M.set_tags_bindings()
    M.set_keybindings()
    M.set_client_keybindings()
    M.set_ignored_bindings()

    root.keys(M.globalkeys)
end

return M

