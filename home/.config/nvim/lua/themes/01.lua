local function get_xcolor (c)
   local command = io.popen('xrdb -query | grep ' .. c .. ' -m 1 | cut -f 2')
   local color = command:read("*l")
   print("HELLO")
   return color
end

local M = {
    none = "NONE",

    bg          = get_xcolor("background"),
    fg          = get_xcolor("foreground"),


    black       = get_xcolor("color0"),
    red         = get_xcolor("color1"),
    green       = get_xcolor("color2"),
    yellow      = get_xcolor("color3"),
    blue        = get_xcolor("color4"),
    magenta     = get_xcolor("color5"),
    cyan        = get_xcolor("color6"),
    white       = get_xcolor("color7"),

    black2      = get_xcolor("color8"),
    red2        = get_xcolor("color9"),
    green2      = get_xcolor("color10"),
    yellow2     = get_xcolor("color11"),
    blue2       = get_xcolor("color12"),
    magenta2    = get_xcolor("color13"),
    cyan2       = get_xcolor("color14"),
    white2      = get_xcolor("color15"),
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
                bg_color = M.blue,
                fg_color = M.bg,
            },
            inactive_tab = {
                bg_color = M.bg,
                fg_color = M.fg,
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

return M
