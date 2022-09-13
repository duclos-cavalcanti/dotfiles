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

    black       = "#120f12",
    red         = "#3f3442", --#7d6c82
    green       = "#222827",
    yellow      = "#a8c278",
    blue        = "#485559",
    magenta     = "#654a96",
    cyan        = "#a9d1df",
    white       = "#495151",

    black2      = "#485559", -- #19171c
    red2        = "#cd749c",
    green2      = "#63b0b0",
    yellow2     = "#a8c278",
    blue2       = "#5786bc",
    magenta2    = "#9c75dd",
    cyan2       = "#89d9d0",
    white2      = "#9898ae",
}

M.grey = M.white
M.grey2 = M.white2

M.editor = {
    primary = M.green2,
    secondary = M.magenta,
    tertiary = M.cyan,
}

M.wm = {

}

return M
