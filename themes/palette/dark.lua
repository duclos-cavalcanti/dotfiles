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

    black       = "#19171c",
    red         = "#cd749c",
    green       = "#63b0b0",
    yellow      = "#a89984",
    blue        = "#5d6f74",
    magenta     = "#654a96",
    cyan        = "#539191",
    white       = "#495151",

    black2      = "#222827",
    red2        = "#75657a", -- #3f3442
    green2      = "#485559",
    yellow2     = "#99450f",
    blue2       = "#5786bc",
    magenta2    = "#9c75dd",
    cyan2       = "#89d9d0", -- #539191
    white2      = "#9898ae",
}

M.grey = M.white
M.grey2 = M.white2

M.editor = {
    comment     = M.green2,
    error       = {
        bg = M.black,
        fg = M.red,
    },
    warning     = {
        bg = M.blue2,
        fg = M.white,
    },
    hint     = {
        fg = M.white2,
    },
    info     = {
        fg = M.fg,
    },
    ui          = {
        border      = M.black2,  -- split, vertsplit
        colorcolumn = M.black,
        cursorline  = M.black2,
        statusline  = {
            bg = M.black2,
            fg = M.green2,
            nc = {
                bg = M.black2,
                fg = M.white2,
            },
            line = {
                a = {
                    normal = {
                        bg = M.green2,
                        fg = M.black,
                    },
                    insert = {
                        bg = M.black2,
                        fg = M.red,
                    },
                    visual = {
                        bg = M.black,
                        fg = M.magenta,
                    },
                },
                b = {
                    bg = M.black,
                    fg = M.fg,
                },
            }
        },
        tabline  = {
            bg = M.black2,
            fg = M.green,
            sel = {
                bg = M.green2,
                fg = M.black,
            }
        },
        popmenu     = {
            bg = M.black,
            fg = M.magenta2,
            sel = M.green,
            sbar = {
                bg = M.black2,
                fg = M.magenta
            },
            thumb = {
                bg = M.white2,
                fg = M.black2
            }
        },
        sidebar  = {
            bg = M.black,
            fg = M.green,
            nc = {
                bg = M.black2,
                fg = M.white2,
            }
        },
    },
    diff    = {
        add     = M.green,
        change  = M.blue2,
        delete  = M.red,
        text    = M.white2,
    },
    visual = {
        bg = M.black,
    },
}

M.wm = {
    bar = {
        bg = M.bg,
        fg = M.fg
    },
    titlebar = {
        normal = M.black,
        focus = M.black,
    },
    border = {

    },
    separator = M.black2,
    notification = {
        bg = M.bg,
        fg = M.fg,
        border = M.cyan,
    },
}

return M
