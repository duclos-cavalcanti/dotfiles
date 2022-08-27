local utils = require("utils")
local home_path = utils.home_path

local path = home_path() .. "/.config/nvim/pack/pack/start/custom-scheme/lua/custom-scheme/palette/"
local default = {
    bg = "#141B36",
    fg = "#d8dee9",

    black       = "#253049",
    red         = "#ff2c4b",
    green       = "#50FA7B",
    yellow      = "#ffd57f",
    blue        = "#74b2ff",
    magenta     = "#ff79c6",
    cyan        = "#7dcfff",
    white       = "#616E88",

    black2      = "#1F283C",
    red2        = "#ff5189",
    green2      = "#79dac8",
    yellow2     = "#e3c78a",
    blue2       = "#88c0d0",
    magenta2    = "#bb9af7",
    cyan2       = "#8be9fd",
    white2      = "#d8dee9",
}

local M = {}

function M.get_palette(file)
    return utils.load_file(file)
end

function M.setup(name)
    local file = path .. name .. ".lua"
    local colors = nil

    if utils.file_exists(file) then
        colors = M.get_palette(file)
    else
        colors = default
    end

    colors.background = colors.bg
    colors.foreground = colors.fg
    colors.grey = colors.white
    return colors
end

return M
