local M = {
    none = "NONE",

    bg = "#0D1117", -- #2e3440
    fg = "#F4F4F4",


    black       = "#2e3440",
    red         = "#bf616a",
    green       = "#a3be8c",
    yellow      = "#ebcb8b",
    blue        = "#81a1c1",
    magenta     = "#b48ead",
    cyan        = "#88c0d0",
    white       = "#4B5368",

    black2      = "#3A4151",
    red2        = "#bf616a",
    green2      = "#a3be8c",
    yellow2     = "#ebcb8b",
    blue2       = "#81a1c1",
    magenta2    = "#b48ead",
    cyan2       = "#8fbcbb",
    white2      = "#eceff4",
}

M.grey = M.white
M.grey2 = M.white2

M.editor = {
    functions       = M.green,
    fbuiltin        = M.red,
    fparameters     = M.fg,
    method          = M.red,
    constructor     = M.blue,
    namespace       = M.green,
    var             = M.fg,
    field           = M.fg,
    type            = M.cyan,
    structure       = M.red,
    bool            = M.magenta,
    storage         = M.cyan,
    string          = M.yellow,
    char            = M.yellow,
    number          = M.red,
    constant        = M.red,
    preproc         = M.magenta,
    statement       = M.red,
    keyword         = M.red,
    forwords        = M.magenta,    -- conditionals, loops
    label           = M.red,      -- goto's, names
    operator        = M.yellow,
    comment         = M.grey,
    linenr          = M.grey,
    cur_linenr      = M.white2,
    column          = M.bg,
    punctuation     = M.cyan,
    special         = M.blue,
    icons           = M.blue2,
    text            = {
        todo = M.cyan2,
        title = M.red,        -- titles for output and tabline number of buffers
        tag = M.cyan,
        rare = M.blue2,
    },
    error           = {
        bg = M.black, --column color should match
        fg = M.red2,
    },
    warning     = {
        bg = M.black, --column color should match
        fg = M.grey,
    },
    hint     = {
        bg = M.black, --column color should match
        fg = M.grey,
    },
    info     = {
        bg = M.black, --column color should match
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
                        bg = M.black,
                        fg = M.white2,
                    },
                    insert = {
                        bg = M.black,
                        fg = M.green,
                    },
                    command = {
                        bg = M.black,
                        fg = M.blue,
                    },
                    visual = {
                        bg = M.black,
                        fg = M.magenta,
                    },
                },
                b = {
                    bg = M.black2,
                    fg = M.white2,
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
                bg = M.bg,
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
                fg = M.fg,
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

M.terminal = {
    background = nil, -- background = {{ source = { File = os.getenv("HOME") .. "/.config/awesome/theme/wallpapers/05.png" } }},
    status = {
        background = M.bg,
        foreground = M.fg,
        faded = M.grey,
        user = M.fg,
        ws = M.fg,
    },
    colors = {
        background = M.bg,
        foreground = M.fg,

        ansi = {
          M.black,
          M.red,
          M.green,
          M.yellow,
          M.blue,
          M.magenta,
          M.cyan,
          M.white,
        },

        brights = {
          M.black2,
          M.red2,
          M.green2,
          M.yellow2,
          M.blue2,
          M.magenta2,
          M.cyan2,
          M.white2,
        },

        compose_cursor = M.green,

        cursor_bg = M.red,
        cursor_border = M.red,
        cursor_fg = M.fg,

        split = M.black,
        scrollbar_thumb = M.grey,

        selection_bg = M.fg,
        selection_fg = M.bg,

        quick_select_label_bg = { Color = M.black },
        quick_select_label_fg = { Color = M.fg },
        quick_select_match_bg = { Color = M.red },
        quick_select_match_fg = { Color = M.fg },

        tab_bar = {
            background = M.bg,
            active_tab = {
                bg_color = M.green,
                fg_color = M.bg,
            },
            inactive_tab = {
                bg_color = M.bg,
                fg_color = M.grey,
            },
            new_tab = {
                bg_color = M.bg,
                fg_color = M.fg,
            },
            new_tab_hover = {
                bg_color = M.bg,
                fg_color = M.fg,
            }
        },
    },
}

M.wm = {
    wp  = "01.png",
    wp2  = "01.png",
    generic = { -- default and tasklist
        normal = {
            bg = M.black,
            fg = M.grey,
        },
        focus  = {
            bg = M.bg,
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
            bg = M.black,
            fg = M.fg,
        },
        focus = {
            bg = M.bg,
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
        focus           = M.cyan,
        sticky          = M.red,
        marked          = M.green
    },
    tray = {
        bg = M.bg,
        fg = M.fg,
        popup = M.black,
    },
    prompt = {
        bg = M.bg,
        fg = M.fg,
    },
    menu = {
        normal  = M.black,
        focus   = {
            bg = M.black,
            fg = M.fg,
        },
        border  = M.black,
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
            bg = M.cyan,
            fg = M.bg,
        },
        urgent = {
            bg = M.magenta2,
            fg = M.fg,
        },
    },
    separator = M.black,
    notification = {
        bg = M.black,
        fg = M.fg,
        border = M.cyan,
    },
}

return M
