local M = {
    none = "NONE",

    bg = "#222222",
    fg = "#FAFAFA",
    -- based on
    -- https://ubuntu-mate.org/
    black       = "#272727", -- #2C2C2C
    red         = "#e01a4f",
    green       = "#87a556",
    yellow      = "#f9c22e",
    blue        = "#43acc7", -- #84a752
    magenta     = "#8E56A4",
    cyan        = "#84dcc6",
    white       = "#616161",

    black2      = "#151515", -- #3C3B37
    red2        = "#f15946",
    green2      = "#a9be61",
    yellow2     = "#cdcebf",
    blue2       = "#43acc7",
    magenta2    = "#A45686",
    cyan2       = "#84dcc6",
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
    field           = M.green2,
    type            = M.blue,
    structure       = M.cyan2,
    bool            = M.red,
    storage         = M.blue2,
    string          = M.yellow2,
    char            = M.red,
    number          = M.blue2,
    constant        = M.blue2,
    preproc         = M.red2,
    statement       = M.yellow,
    keyword         = M.magenta2,
    forwords        = M.green,    -- conditionals, loops
    label           = M.red,      -- goto's, names
    operator        = M.magenta,
    comment         = M.grey,
    linenr          = M.grey,
    cur_linenr      = M.yellow,
    column          = M.black2,
    punctuation     = M.magenta,
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
        fg = M.red2,
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
    window_frame = {
        active_titlebar_bg = M.bg,
        inactive_titlebar_bg = M.black2,
    },
    window_padding = {
        left =  5,
        right = 0,
        top = 10,
        bottom = 2,
    },
    colors = {
        background = M.bg,
        foreground = M.fg,

        compose_cursor = M.yellow,
        cursor_bg = M.red,
        cursor_fg = M.yellow,
        cursor_border = M.red,

        split = M.green,
        scrollbar_thumb = M.grey,

        selection_bg = M.fg,
        selection_fg = M.bg,

        quick_select_label_bg = { Color = M.fg },
        quick_select_label_fg = { Color = M.bg },
        quick_select_match_bg = { Color = M.red },
        quick_select_match_fg = { Color = M.fg },

        copy_mode_active_highlight_bg = { Color = M.fg },
        copy_mode_active_highlight_fg = { Color = M.bg },
        copy_mode_inactive_highlight_bg = { Color = M.red },
        copy_mode_inactive_highlight_fg = { Color = M.fg },

        tab_bar = {
            active_tab = {
                bg_color = M.green,
                fg_color = M.fg,
            },
            inactive_tab = {
                bg_color = M.bg,
                fg_color = M.fg,
            },
            new_tab = {
                bg_color = M.bg,
                fg_color = M.bg,
            },
            inactive_tab_edge = M.bg,
        },

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
    }
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
            bg = M.black,
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
