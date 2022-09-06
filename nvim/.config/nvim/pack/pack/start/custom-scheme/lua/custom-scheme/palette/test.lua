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

    black       = "#2f393b", -- #1a1e1d
    red         = "#d95490", -- #c7566f
    green       = "#41b193",
    yellow      = "#a8c278",
    blue        = "#97c4ba", -- #3788a2 -- #5786bc
    magenta     = "#d5a8e4", -- #9c75dd -- #62438a
    cyan        = "#7ed2c8", -- #89d9d0
    white       = "#9898ae", -- #353f4c

    black2      = "#1f1f1f",
    red2        = "#d95490",
    green2      = "#609f83",
    yellow2     = "#a8c278",
    blue2       = "#5786bc",
    magenta2    = "#2d327c",
    cyan2       = "#89d9d0",
    white2      = "#b4ece6",
}

M.primary = M.green
M.secondary = M.red
M.tertiary = M.blue
M.wallpaper = M.bg

return M
