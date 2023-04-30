local M = {
    none = "NONE",

    bg = "#080808", -- #222222
    fg = "#FAFAFA",


    black       = "#2C2C2C", -- #2C2C2C
    red         = "#FF5454",
    green       = "#00FF28",
    yellow      = "#FEFE00",
    blue        = "#74b2ff",
    magenta     = "#D22CCF",
    cyan        = "#84dcc6",
    white       = "#A9A9A9",

    black2      = "#151515",
    red2        = "#FF5189",
    green2      = "#36c692",
    yellow2     = "#E3C78A",
    blue2       = "#74b2ff",
    magenta2    = "#8C87FB",
    cyan2       = "#84dcc6",
    white2      = "#FAFAFA",
}

M.grey = M.white
M.grey2 = M.white2

M.editor = {
    functions       = M.yellow,
    fbuiltin        = M.green,
    fparameters     = M.fg,
    method          = M.cyan,
    constructor     = M.magenta,
    namespace       = M.magenta2,
    var             = M.fg,
    field           = M.white2,
    type            = M.green,
    structure       = M.cyan2,
    bool            = M.red,
    storage         = M.red,
    string          = M.fg,
    char            = M.red,
    number          = M.green2,
    constant        = M.magenta,
    preproc         = M.magenta2,
    statement       = M.yellow,
    keyword         = M.green,
    forwords        = M.green,    -- conditionals, loops
    label           = M.red,      -- goto's, names
    operator        = M.grey,
    comment         = M.grey,
    linenr          = M.grey,
    cur_linenr      = M.yellow,
    column          = M.black2,
    punctuation     = M.red,
    special         = M.green,
    icons           = M.blue2,
    text            = {
        todo = M.cyan2,
        title = M.red,        -- titles for output and tabline number of buffers
        tag = M.cyan,
        rare = M.blue2,
    },
    error           = {
        bg = M.black2, --column color should match
        fg = M.red,
    },
    warning     = {
        bg = M.black2, --column color should match
        fg = M.grey,
    },
    hint     = {
        bg = M.black2, --column color should match
        fg = M.white2,
    },
    info     = {
        bg = M.black2, --column color should match
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
                    fg = M.yellow2,
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

M.terminal = {
    background = nil, -- background = {{ source = { File = os.getenv("HOME") .. "/.config/awesome/theme/wallpapers/05.png" } }},
    status = {
        background = M.bg,
        foreground = M.fg,
        faded = M.grey,
        user = M.green,
        ws = M.green,
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

        compose_cursor = M.red,

        cursor_bg = M.green,
        cursor_border = M.green,
        cursor_fg = M.bg,

        split = M.grey,
        scrollbar_thumb = M.grey,

        selection_bg = M.fg,
        selection_fg = M.bg,

        quick_select_label_bg = { Color = M.black },
        quick_select_label_fg = { Color = M.fg },
        quick_select_match_bg = { Color = M.red },
        quick_select_match_fg = { Color = M.fg },

        tab_bar = {
            background = M.black2,
            active_tab = {
                bg_color = M.green,
                fg_color = M.black2,
            },
            inactive_tab = {
                bg_color = M.black2,
                fg_color = M.grey,
            },
            new_tab = {
                bg_color = M.black2,
                fg_color = M.green,
            },
            new_tab_hover = {
                bg_color = M.black2,
                fg_color = M.green,
            }
        },
    },
}

M.wm = {
    wp  = "ubuntu_mate.png",
    wp2  = "ubuntu_mate_no_logo.png",
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
            bg = M.bg,
            fg = M.grey,
        },
        focus = {
            bg = M.black2,
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
        focus           = M.fg,
        sticky          = M.red,
        marked          = M.blue2
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
            bg = M.grey,
            fg = M.bg,
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
