local awful = require("awful")
local gears = require("gears")

local M = {}
local C = {
    ['duclos'] = {
        nr = 3,
        displays = {
            ['eDP1'] = 'xrandr --output eDP1 --mode 1920x1080',
            ['DP2-2'] = 'xrandr --output DP2-2 --rotate left --right-of eDP1'
        }
    },
}

local function wp(s, hwp, vwp)
    local w = s.geometry.width
    local h = s.geometry.height

    if w > h then   -- horizontal
        gears.wallpaper.maximized(hwp, s, false)
    else            -- vertical
        gears.wallpaper.maximized(vwp, s, false)
    end
end

local function set_wallpaper(s)
    local hwp   = beautiful.wp
    local vwp   = beautiful.wp2
    wp(s, hwp, vwp)
end

local function set_monitors()
    local config = C[os.getenv('USER')]

    local function run(cmd)
        local f = assert(io.popen(cmd,'r'))
        local s = assert(f:read('*a'))
        return string.gsub(s, '[\n\r]+', ' ')
    end

    local function get_nr_displays()
        local number=run("xrandr | grep ' connected' | wc -l")
        return tonumber(number)
    end

    local function check_displays(c)
        local i = 0
        local j = 0
        local displays=run("xrandr | grep --color=NEVER ' connected' | awk '{print $1}'")

        for k, _ in pairs(c.displays) do
            j = j + 1
            for s in string.gmatch(displays, "([^%s]+)") do
                if k == s then
                    i = i + 1
                end
            end
        end

        return (i == j)
    end

    if config ~= nil then
        if config.nr == get_nr_displays() then
            if check_displays(config) then
                for _,v in pairs(config.displays) do
                    os.execute(v)
                end
            else
                print("Displays missmatch in monitors config!")
            end
        else
            print("Number of displays missmatch in monitors config!")
        end
    else
        print(os.getenv("USER") .. " is not found in the monitors config!")
    end
end

function M.setup()
    -- screen property hook
    screen.connect_signal("property::geometry", function(s)
        set_wallpaper(s)
    end)

    -- screen hook for each screen
    awful.screen.connect_for_each_screen(function(s)
        set_wallpaper(s)
        awful.tag(taglist, s, awful.layout.layouts[1])  -- setting taglist per screen
        require("interface.bar").setup(s)               -- setting up bar
    end)

    set_monitors()
end

return M
