local M = {
    none = "NONE",

    bg = "#222222",
    fg = "#FAFAFA",
    -- based on
    -- https://ubuntu-mate.org/
    -- #4E9A05, #05989A, #2E3436, #EF2929, #C4A000
    black       = "#272727", -- #2C2C2C
    red         = "#DD4813",
    green       = "#87a556",
    yellow      = "#A48E56",
    blue        = "#5A56A4",
    magenta     = "#8E56A4",
    cyan        = "#56A474",
    white       = "#616161",

    black2      = "#151515", -- #3C3B37
    red2        = "#DD4813",
    green2      = "#a9be61",
    yellow2     = "#3C3B37",
    blue2       = "#5686A4",
    magenta2    = "#A45686",
    cyan2       = "#56A49B",
    white2      = "#FAFAFA",
}

M.grey = M.white
M.grey2 = M.white2

M.editor = {
    functions       = M.green,
    fbuiltin        = M.red,
    fparameters     = M.fg,
    method          = M.green,
    constructor     = M.green,
    namespace       = M.grey,
    var             = M.fg,
    field           = M.cyan,
    type            = M.blue2,
    structure       = M.cyan2,
    bool            = M.red,
    storage         = M.blue,
    string          = M.yellow,
    char            = M.red,
    number          = M.blue,
    constant        = M.blue,
    preproc         = M.magenta2,
    statement       = M.yellow,
    keyword         = M.magenta2,
    forwords        = M.green,    -- conditionals, loops
    label           = M.red,      -- goto's, names
    operator        = M.magenta,
    comment         = M.grey,
    linenr          = M.grey,
    cur_linenr      = M.yellow,
    punctuation     = M.fg,
    special         = M.green,
    icons           = M.blue,
    text            = {
        todo = M.cyan2,
        title = M.red,        -- titles for output and tabline number of buffers
        tag = M.cyan,
        rare = M.blue2,
    },
    error           = {
        bg = M.black,
        fg = M.red2,
    },
    warning     = {
        bg = M.black,
        fg = M.grey,
    },
    hint     = {
        fg = M.white2,
    },
    info     = {
        fg = M.fg,
    },
    success  = {
        fg = M.green,
    },
    diff    = {
        add     = M.green,
        change  = M.blue2,
        delete  = M.red2,
        text    = M.fg,
        line    = M.fg,
        file    = M.blue,
    },
    visual = {
        bg = M.fg,
        fg = M.bg,
    },
    search = {
        bg = M.yellow,
        fg = M.bg,
        inc_bg = M.black,
        inc_fg = M.cyan,
        substitute = M.red,
    },
    ui        = {
        border      = M.black,  -- split, vertsplit
        line        = M.blue2,
        colorcolumn = M.none,
        cursorline  = M.none,
        directory   = M.green,
        wildmenu    = M.red,
        statusline  = {
            bg = M.black,
            fg = M.fg,
            nc = {
                bg = M.bg,
                fg = M.fg,
            },
            line = {
                a = {
                    normal = {
                        bg = M.yellow2,
                        fg = M.fg,
                    },
                    insert = {
                        bg = M.yellow2,
                        fg = M.green,
                    },
                    command = {
                        bg = M.yellow2,
                        fg = M.yellow,
                    },
                    visual = {
                        bg = M.yellow2,
                        fg = M.magenta,
                    },
                },
                b = {
                    bg = M.black,
                    fg = M.fg,
                },
                c = {
                    bg = M.black2,
                    fg = M.grey,
                },
            }
        },
        tabline  = {
            bg = M.bg,
            fg = M.grey,
            fill = M.bg,
            selected = {
                bg = M.black2,
                fg = M.fg,
            }
        },
        popmenu     = {
            bg = M.black,
            fg = M.magenta2,
            kind = M.red,
            fuzzy = M.fg,
            abbreviation = M.red,
            selected = M.blue,
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
            bg_alt = M.black2,
            fg = M.green,
            nc = {
                bg = M.black,
                fg = M.white2,
            }
        },
        floatwin = {
                bg = M.bg,
                bg_alt = M.black2,
                fg = M.fg,
                border = M.grey,
                prompt = M.red,
                match = M.red,
                selected = {
                    bg = M.black,
                    fg = M.yellow,
                }
        }
    },
}

M.wm = {
    wp  = "02.png",
    wp2 = "04.png",
    generic = { -- default and tasklist
        normal = {
            bg = M.bg,
            fg = M.grey,
        },
        focus  = {
            bg = M.black2,
            fg = M.fg,
        },
        urgent = {
            bg = M.red,
            fg = M.fg,
        },
        min = {
            bg = M.grey,
            fg = M.fg,
        },
    },
    titlebar = {
        normal =  {
            bg = M.black2,
            fg = M.fg,
        },
        focus = {
            bg = M.green,
            fg = M.fg,
        }
    },
    bar = {
        bg          = M.black2,
        fg          = M.fg,
        highlight   = M.green,
    },
    border = {
        normal          = M.grey,
        focus           = M.green,
        sticky          = M.red,
        marked          = M.blue
    },
    tray = {
        bg = M.black2,
        fg = M.fg,
        popup = M.black2,
    },
    prompt = {
        bg = M.black2,
        fg = M.fg,
    },
    menu = {
        normal  = M.black2,
        focus   = {
            bg = M.black,
            fg = M.fg,
        },
        border  = M.black,
    },
    clock = {
        bg = M.black2,
        fg = M.fg,
    },
    tag = {
        empty = {
            bg = M.black2,
            fg = M.grey,
        },
        occ = {
            bg = M.black2,
            fg = M.fg,
        },
        focus = {
            bg = M.green,
            fg = M.fg,
        },
        urgent = {
            bg = M.magenta2,
            fg = M.fg,
        },
    },
    separator = M.black2,
    notification = {
        bg = M.black2,
        fg = M.fg,
        border = M.cyan,
    },
}

return M
