local wibox = require("wibox")
local gears = require("gears")
local timer = require("gears.timer")

local M = {}

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

return M
