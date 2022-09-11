--[[
-- black  used for:  Tabline Background Selected / Lualine "B"
-- grey   used for:  Comments / Lualine "A"
-- black2 used for:  Tabline Background / StatusLine (Lualine "C")
--                   CursorLine / Columline
--]]

local M = {
    none = "NONE",

    bg = "#0f0f10",
    fg = "#e1d9ea",

    black       = "#222827", -- #222827
    red         = "#d95490", -- #d8a2ea
    green       = "#41b193",
    yellow      = "#a8c278",
    blue        = "#97c4ba", -- #b6a6d4 #654a96
    magenta     = "#9c75dd", -- #9c75dd
    cyan        = "#7ed2c8",
    white       = "#495151", -- #495151

    black2      = "#5d6f74", -- #5d6f74
    red2        = "#cd749c", -- #cd749c
    green2      = "#63b0b0", -- #63b0b0
    yellow2     = "#a8c278",
    blue2       = "#5786bc", -- #233b57
    magenta2    = "#654a96",
    cyan2       = "#89d9d0", -- #66919a
    white2      = "#9898ae",
}

M.primary = M.green
M.secondary = M.red
M.tertiary = M.cyan

M.grey = M.white
M.grey2 = M.white2

return M
