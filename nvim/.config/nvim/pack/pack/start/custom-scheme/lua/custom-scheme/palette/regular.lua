--[[
-- black  used for:  Tabline Background Selected / Lualine "B"
-- grey   used for:  Comments / Lualine "A"
-- black2 used for:  Tabline Background / StatusLine (Lualine "C")
--                   CursorLine / Columline
--]]

local M = {
    none = "NONE",
    -- #2E3440 based nord bg  a shade darker
    -- #2C313C a shade darker from ^^
    -- #101622 dark blue found elsewhere
    -- #141B36 blue from yosemite wallpaper

    bg = "#2C313C",
    fg = "#d8dee9", -- nord white/nord4_gui

    black       = "#4C566A", -- nord dark grey shade
    red         = "#ff2c4b", -- badwolf red/taffy
    green       = "#50FA7B", -- dracula green
    yellow      = "#ffd57f", -- ayu yellow mirage
    blue        = "#74b2ff", -- moonfly sky blue
    magenta     = "#ff79c6", -- dracula pink
    cyan        = "#7dcfff", -- tokyonight cyan
    white       = "#616E88", -- nord grey

    black2      = "#3B4252", -- nord light grey shade
    red2        = "#ff5189", -- moonfly red/crimson
    green2      = "#79dac8", -- moonfly green/turquioise
    yellow2     = "#e3c78a", -- moonfly yellow
    blue2       = "#88c0d0", -- nord light blue
    magenta2    = "#bb9af7", -- tokyonight magenta
    cyan2       = "#8be9fd", -- dracula cyan
    white2      = "#d8dee9", -- nord white/nord4_gui

    primary     = "#74b2ff",
    secondary   = "#50FA7B",
}

M.primary = M.blue
M.secondary = M.red
M.tertiary = M.green

M.grey = M.white
M.grey2 = M.white2

return M
