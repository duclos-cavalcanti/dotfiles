--[[
-- black  used for:  Tabline Background Selected / Lualine "B"
-- grey   used for:  Comments / Lualine "A"
-- black2 used for:  Tabline Background / StatusLine (Lualine "C")
--                   CursorLine / Columline
--]]

local M = {
    none = "NONE",

    bg = "#FCFCFC",
    fg = "#000000",

    black       = "#241F31",
    red         = "#ED333B",
    green       = "#5BC8AF",
    yellow      = "#F9F06B",
    blue        = "#3584E4",
    magenta     = "#C061CB",
    cyan        = "#26A1A2",
    white       = "#9A9996",

    black2      = "#3D3846",
    red2        = "#ED333B",
    green2      = "#5BC8AF",
    yellow2     = "#F9F06B",
    blue2       = "#3584E4",
    magenta2    = "#C061CB",
    cyan2       = "#26A1A2",
    white2      = "#C0BFBC",

    primary     = "#3584E4",
    secondary   = "#ED333B",
}

M.primary = M.blue
M.secondary = M.red
M.tertiary = M.green

M.grey = M.white
M.grey2 = M.white2

return M
