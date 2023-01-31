local M = {
    none = "NONE",

    bg = "#2C001E", -- ubuntu aubergine dark, mid #5E2750, light #77216F, canonical #772953
    fg = "#ffffff",
    -- based on
    -- https://design.ubuntu.com/brand/colour-palette/
    black       = "#000000", -- ubuntu text grey
    red         = "#E95420", -- ubuntu orange
    green       = "#60ff00",
    yellow      = "#ffff60",
    blue        = "#80a0ff",
    magenta     = "#77216F",
    cyan        = "#03f6b9",
    white       = "#AEA79F", -- ubuntu warm grey,

    black2      = "#333333", -- ubuntu cool grey
    red2        = "#ffa0a0",
    green2      = "#60ff00",
    yellow2     = "#ffff60",
    blue2       = "#80a0ff",
    magenta2    = "#ff80ff",
    cyan2       = "#03f6b9",
    white2      = "#ffffff",
}

M.grey = M.white
M.grey2 = M.white2

M.editor = {
    functions       = M.cyan,
    fbuiltin        = M.cyan,
    fparameters     = M.yellow,
    method          = M.green,
    constructor     = M.green,
    namespace       = M.grey,
    var             = M.fg,
    field           = M.blue,
    type            = M.green,
    structure       = M.green,
    bool            = M.red,
    storage         = M.blue,
    string          = M.red2,
    char            = M.yellow,
    number          = M.red,
    constant        = M.red,
    preproc         = M.magenta2,
    statement       = M.yellow,
    keyword         = M.blue,
    forwords        = M.yellow,     -- conditionals, loops
    label           = M.cyan2,      -- goto's, names
    operator        = M.magenta2,
    comment         = M.grey,
    linenr          = M.grey,
    cur_linenr      = M.yellow,
    punctuation     = M.fg,
    special         = M.magenta,
    icons           = M.blue,
    text            = {
        todo = M.green2,
        title = M.red,        -- titles for output and tabline number of buffers
        tag = M.cyan2,
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
                        bg = M.magenta,
                        fg = M.fg,
                    },
                    insert = {
                        bg = M.magenta,
                        fg = M.green,
                    },
                    command = {
                        bg = M.magenta,
                        fg = M.magenta2,
                    },
                    visual = {
                        bg = M.black,
                        fg = M.magenta,
                    },
                },
                b = {
                    bg = M.black2,
                    fg = M.fg,
                },
                c = {
                    bg = M.black,
                    fg = M.grey,
                },
            }
        },
        tabline  = {
            bg = M.black2,
            fg = M.grey,
            fill = M.bg,
            selected = {
                bg = M.magenta,
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
            bg = M.black,
            fg = M.grey,
        },
        focus  = {
            bg = M.black2,
            fg = M.fg,
        },
        urgent = {
            bg = M.red2,
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
            bg = M.black,
            fg = M.fg,
        }
    },
    bar = {
        bg          = M.black,
        fg          = M.fg,
        highlight   = M.red,
    },
    border = {
        normal          = M.black,
        focus           = M.red,
        sticky          = M.magenta,
        marked          = M.blue
    },
    tray = {
        bg = M.black,
        fg = M.fg,
        popup = M.black2,
    },
    prompt = {
        bg = M.black,
        fg = M.fg,
    },
    menu = {
        normal  = M.black,
        focus   = {
            bg = M.black2,
            fg = M.fg,
        },
        border  = M.black2,
    },
    clock = {
        bg = M.black,
        fg = M.fg,
    },
    tag = {
        empty = {
            bg = M.black,
            fg = M.grey,
        },
        occ = {
            bg = M.black,
            fg = M.fg,
        },
        focus = {
            bg = M.red,
            fg = M.fg,
        },
        urgent = {
            bg = M.grey,
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
