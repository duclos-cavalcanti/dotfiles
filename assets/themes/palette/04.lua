local M = {
    none = "NONE",

    bg = "#060804", --#080B05, #070E06, #0a0e06
    fg = "#fefae0",
    -- based on
    -- https://design.ubuntu.com/brand/colour-palette/
    black       = "#341a08", --#080B05
    red         = "#dca3a3",
    green       = "#88b090",
    yellow      = "#ffd7a7", --#EED8BD
    blue        = "#71c4d1",
    magenta     = "#e89393", --#9e6862
    cyan        = "#71d3b4",
    white       = "#5d6262",

    black2      = "#151c0D",
    red2        = "#dc8c6c",
    green2      = "#070E06",
    yellow2     = "#ffd7a7",
    blue2       = "#c8e7ec",
    magenta2    = "#f18c96",
    cyan2       = "#ccd990",
    white2      = "#ffffff",
}

M.grey = M.white
M.grey2 = M.white2

M.editor = {
    functions       = M.cyan,
    fbuiltin        = M.blue,
    fparameters     = M.fg,
    method          = M.green,
    constructor     = M.green,
    namespace       = M.grey,
    var             = M.fg,
    field           = M.cyan,
    type            = M.cyan2,
    structure       = M.cyan2,
    bool            = M.red,
    storage         = M.blue,
    string          = M.yellow,
    char            = M.yellow,
    number          = M.blue,
    constant        = M.blue,
    preproc         = M.magenta2,
    statement       = M.yellow,
    keyword         = M.magenta2,
    forwords        = M.yellow,     -- conditionals, loops
    label           = M.cyan,      -- goto's, names
    operator        = M.magenta,
    comment         = M.grey,
    linenr          = M.grey,
    cur_linenr      = M.yellow,
    punctuation     = M.red,
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
                        bg = M.black2,
                        fg = M.fg,
                    },
                    insert = {
                        bg = M.black2,
                        fg = M.green,
                    },
                    command = {
                        bg = M.black2,
                        fg = M.yellow,
                    },
                    visual = {
                        bg = M.black2,
                        fg = M.magenta,
                    },
                },
                b = {
                    bg = M.black,
                    fg = M.fg,
                },
                c = {
                    bg = M.bg,
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
    wp = "02.png",
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
            bg = M.green2,
            fg = M.fg,
        },
        focus = {
            bg = M.black2,
            fg = M.fg,
        }
    },
    bar = {
        bg          = M.bg,
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
        bg = M.bg,
        fg = M.fg,
        popup = M.black2,
    },
    prompt = {
        bg = M.bg,
        fg = M.fg,
    },
    menu = {
        normal  = M.bg,
        focus   = {
            bg = M.black2,
            fg = M.fg,
        },
        border  = M.black2,
    },
    clock = {
        bg = M.bg,
        fg = M.fg,
    },
    tag = {
        empty = {
            bg = M.bg,
            fg = M.grey,
        },
        occ = {
            bg = M.bg,
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
        bg = M.bg,
        fg = M.fg,
        border = M.cyan,
    },
}

return M
