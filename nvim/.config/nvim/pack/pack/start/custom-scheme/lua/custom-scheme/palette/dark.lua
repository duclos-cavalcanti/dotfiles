--[[
-- black  used for:  Tabline Background Selected / Lualine "B"
-- grey   used for:  Comments / Lualine "A"
-- black2 used for:  Tabline Background / StatusLine (Lualine "C")
--                   CursorLine / Columline
--]]

local M =  {
    none = "NONE",
    -- Mixture of:
    -- https://github.com/Barbaross93/Muspelheim/
    -- https://github.com/Mofiqul/adwaita.nvim/
    -- #468c98 , added by me

    bg = "#1c1c1c",
    fg = "#dfdfaf",

    black       = "#262626",
    red         = "#af5f5f",
    green       = "#87875f",
    yellow      = "#af875f",
    blue        = "#468c98",
    magenta     = "#af8787",
    cyan        = "#87afaf",
    white       = "#626262",

    black2      = "#353535",
    red2        = "#af5f5f",
    green2      = "#87875f",
    yellow2     = "#af875f",
    blue2       = "#468c98",
    magenta2    = "#af8787",
    cyan2       = "#87afaf",
    white2      = "#dfdfaf",
}

M.primary = M.red
M.secondary = M.cyan
M.tertiary = M.green

M.grey = M.white
M.grey2 = M.white2

return M
