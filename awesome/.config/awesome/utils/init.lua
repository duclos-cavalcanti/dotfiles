local gears = require("gears")
local timer = require("gears.timer")

local M = {}

M.startup = true

function M.set_timer(args)
    if type(args.callback) ~= "function" then return nil, false end

    local t = timer({
        timeout = args.timeout or 10,
        callback = args.callback
    })

    t:start()
    return t, true
end

function M.color_text(c, text)
    local prefix = "<span foreground='"
    local suffix = "</span>"
    return prefix .. c .. "'>" .. text .. suffix
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

function M.user()
    return os.getenv("USER")
end

function M.home_path()
    return os.getenv("HOME")
end

function M.config_path()
    return gears.filesystem.get_configuration_dir()
end

function M.palette_path()
    return M.home_path() .. "/.dotfiles/themes/palette"
end

function M.log(var, msg)
    local file = M.config_path() .. "awesome.log"
    local operator = ""
    local command = ""

    if M.startup then
        operator = ">"
        M.startup = false
    else
        operator = ">>"
    end

    command = string.format("echo '%s: %s' %s %s", var, msg, operator, file)
    os.execute(command)
end

return M
