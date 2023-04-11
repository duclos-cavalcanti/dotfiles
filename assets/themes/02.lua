local M = {
    none = "NONE",

    bg = "#D7C598",
    fg = "#000000",
    -- based on
    -- https://wezfurlong.org/wezterm/index.html
    black       = "#3E3B32",
    red         = "#D82330",
    green       = "#1C8557",
    yellow      = "#666E5F",
    blue        = "#113933",
    magenta     = "#1F5084",
    cyan        = "#0E8891",
    white       = "#998663",

    black2      = "#74655E",
    red2        = "#93472D",
    green2      = "#016644",
    yellow2     = "#666E5F",
    blue2       = "#113933",
    magenta2    = "#1F5084",
    cyan2       = "#0E8891",
    white2      = "#FAFAFA",
}

M.grey = M.white
M.grey2 = M.white2

M.editor = {
    functions       = M.red,
    fbuiltin        = M.green2,
    fparameters     = M.fg,
    method          = M.cyan,
    constructor     = M.green,
    namespace       = M.blue,
    var             = M.fg,
    field           = M.green2,
    type            = M.green,
    structure       = M.cyan,
    bool            = M.red,
    storage         = M.blue,
    string          = M.yellow,
    char            = M.red,
    number          = M.red,
    constant        = M.red2,
    preproc         = M.red2,
    statement       = M.yellow,
    keyword         = M.blue,
    forwords        = M.green,    -- conditionals, loops
    label           = M.red,      -- goto's, names
    operator        = M.magenta,
    comment         = M.grey,
    linenr          = M.grey,
    cur_linenr      = M.yellow,
    column          = M.black,
    punctuation     = M.magenta,
    special         = M.blue,
    icons           = M.blue,
    text            = {
        todo = M.cyan2,
        title = M.red,        -- titles for output and tabline number of buffers
        tag = M.cyan,
        rare = M.blue2,
    },
    error           = {
        bg = M.black, --column color should match
        fg = M.red,
    },
    warning     = {
        bg = M.black, --column color should match
        fg = M.grey,
    },
    hint     = {
        bg = M.black, --column color should match
        fg = M.white2,
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
                        fg = M.yellow,
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
                bg = M.black,
                fg = M.white2,
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
    -- window_background_image = os.getenv("HOME") .. "/.config/awesome/theme/wallpapers/05.png",
    window_background_image = nil,
    window_background_image_hsb = {
        brightness = 0.1,
        hue = 1.0,
        saturation = 0.1
    },
    status = {
        background = M.bg,
        foreground = M.grey,
        mode = M.yellow,
        ws = M.red,
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

        compose_cursor = M.yellow,

        cursor_bg = M.red,
        cursor_border = M.red,
        cursor_fg = M.fg,

        split = M.green,
        scrollbar_thumb = M.black2,

        selection_bg = M.fg,
        selection_fg = M.bg,

        quick_select_label_bg = { Color = M.black },
        quick_select_label_fg = { Color = M.fg },
        quick_select_match_bg = { Color = M.red },
        quick_select_match_fg = { Color = M.fg },

        tab_bar = {
            background = M.bg,
            active_tab = {
                bg_color = M.green2,
                fg_color = M.fg,
            },
            inactive_tab = {
                bg_color = M.bg,
                fg_color = M.grey,
            },
            new_tab = {
                bg_color = M.bg,
                fg_color = M.bg,
            },
            new_tab_hover = {
                bg_color = M.bg,
                fg_color = M.bg,
            }
        },
    },
}

M.wm = {
    wp  = "ubuntu_mate_grey.png",
    wp2  = "ubuntu_mate_grey_no_logo.png",
    generic = { -- default and tasklist
        normal = {
            bg = M.black,
            fg = M.grey,
        },
        focus  = {
            bg = M.black,
            fg = M.white2,
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
            fg = M.grey,
        },
        focus = {
            bg = M.black,
            fg = M.white2,
        }
    },
    bar = {
        bg          = M.black,
        fg          = M.white2,
        highlight   = M.green,
    },
    border = {
        normal          = M.grey,
        focus           = M.green,
        sticky          = M.red,
        marked          = M.blue2
    },
    tray = {
        bg = M.black,
        fg = M.fg,
        popup = M.black,
    },
    prompt = {
        bg = M.black,
        fg = M.white2,
    },
    menu = {
        normal  = M.black,
        focus   = {
            bg = M.black2,
            fg = M.fg,
        },
        border  = M.black,
    },
    clock = {
        bg = M.black,
        fg = M.white2,
    },
    tag = {
        empty = {
            bg = M.black,
            fg = M.grey,
        },
        occ = {
            bg = M.black,
            fg = M.white2,
        },
        focus = {
            bg = M.green,
            fg = M.white2,
        },
        urgent = {
            bg = M.magenta2,
            fg = M.white2,
        },
    },
    separator = M.black2,
    notification = {
        bg = M.black,
        fg = M.fg,
        border = M.cyan,
    },
}

return M
