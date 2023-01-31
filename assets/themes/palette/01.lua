local M = {
    none = "NONE",

    bg = "#080808",
    fg = "#eeeeee",
    -- based on
    -- https://github.com/olimorris/onedarkpro.nvim
    black       = "#1d2021",
    red         = "#ff5189", --#ef596f, #ff5454, #501b20
    green       = "#89ca78",
    yellow      = "#e5c07b",
    blue        = "#61afef",
    magenta     = "#d55fde",
    cyan        = "#2bbac5",
    white       = "#7f848e",

    black2      = "#282828",
    red2        = "#ff1493",
    green2      = "#50fa7b",
    yellow2     = "#d19a66",
    blue2       = "#4c83ff",
    magenta2    = "#ff79c6",
    cyan2       = "#2bbac5",
    white2      = "#eeeeee",
}

M.grey = M.white
M.grey2 = M.white2

M.editor = {
    func            = M.green2,
    func_builtin    = M.red2,
    var             = M.fg,
    type            = M.magenta2,
    storage         = M.green,
    string          = M.yellow,
    number          = M.green,
    const           = M.cyan,
    preproc         = M.red,
    statement       = M.blue,
    keyword         = M.blue,
    forwords        = M.blue,   -- conditionals, loops
    label           = M.red,        -- goto's, names
    operator        = M.cyan,
    comment         = M.grey,
    linenr          = M.black2,
    clinenr         = M.red2,
    punct           = M.fg,
    title           = M.red,        -- titles for output and tabline number of buffers
    error           = {
        bg = M.black,
        fg = M.red,
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
    ui        = {
        border      = M.black,  -- split, vertsplit
        colorcolumn = M.black,
        cursorline  = M.black,
        statusline  = {
            bg = M.black,
            fg = M.fg,
            nc = {
                bg = M.bg,
                fg = M.black2,
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
                        fg = M.magenta2,
                    },
                    visual = {
                        bg = M.black,
                        fg = M.magenta,
                    },
                },
                b = {
                    bg = M.bg,
                    fg = M.fg,
                },
                c = {
                    bg = M.bg,
                    fg = M.grey,
                },
            }
        },
        tabline  = {
            bg = M.black,
            fg = M.grey,
            fill = M.bg,
            sel = {
                bg = M.black2,
                fg = M.fg,
            }
        },
        popmenu     = {
            bg = M.black,
            fg = M.magenta2,
            fuzzy = M.fg,
            abbr = M.red,
            sel = M.blue,
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
                bg = M.black,
                fg = M.white2,
            }
        },
        floatwin = {
                bg = M.bg,
                fg = M.fg,
                border = M.grey,
                prompt = M.red,
                sel = {
                    bg = M.black,
                    fg = M.yellow,
                }
        }
    },
    diff    = {
        add     = M.green,
        change  = M.blue2,
        delete  = M.red,
        text    = M.white2,
    },
    visual = {
        bg = M.fg,
        fg = M.bg,
    },
}

M.wm = {
    wp = "01.png",
    generic = { -- default and tasklist
        normal = {
            bg = M.black2,
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
            bg = M.magenta2,
            fg = M.fg,
        },
    },
    bar = {
        bg          = M.bg,
        fg          = M.fg,
        highlight   = M.blue,
    },
    titlebar = {
        normal =  {
            bg = M.black2,
            fg = M.fg,
        },
        focus = {
            bg = M.blue,
            fg = M.bg,
        }
    },
    border = {
        normal          = M.black,
        focus           = M.fg,
        sticky          = M.blue,
        marked          = M.red
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
            bg = M.black,
            fg = M.fg,
        },
        urgent = {
            bg = M.red,
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

M.wm.tasklist = M.wm.generic

M.browser = {
    browser_tab_fill = M.bg,
    browser_tab_sel = M.black,
}

return M
