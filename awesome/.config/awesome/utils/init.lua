local wibox = require("wibox")
local gears = require("gears")
local timer = require("gears.timer")

local M = {}

function M.make_timer(args)
    if type(args.callback) ~= "function" then return nil end

    local t = timer({
        timeout = args.timeout or 10,
        call_now = true,
        autostart = true,
        callback = args.callback
    })

    return t
end

function M.marginalize(w, m)
    return wibox.container.margin(
        w,
        m,
        m,
        m,
        m,
        beautiful.wibar_bg
    )
end

function M.config_path()
    return gears.filesystem.get_configuration_dir()
end

function M.load_file(file)
    return dofile(file)
end

function M.file_exists(name)
    local f = io.open(name, "r")

    if f  ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

function M.log( msg)
    local file = M.config_path() .. "awesome.log"
    local operator = ""
    local command = ""

    if M.startup then
        operator = ">"
        M.startup = false
    else
        operator = ">>"
    end

    command = string.format("echo '%s' %s %s", msg, operator, file)
    os.execute(command)
end

return M
