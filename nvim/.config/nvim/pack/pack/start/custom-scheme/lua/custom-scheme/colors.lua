local M = {}

function M.setup(config)
    local colors = require(string.format("custom-scheme.palette.%s", config.palette))

    colors.grey = colors.white

    colors.diff = {
        add = colors.green,
        delete = colors.red,
        change = colors.blue2,
        text = colors.blue2,
    }

    colors.git = {
        add = colors.green1,
        delete = colors.secondary,
        change = colors.blue2,
        conflict = colors.secondary,
        ignore = colors.grey,
    }

    colors.gitSigns = {
        add = colors.green1,
        change = colors.blue2,
        delete = colors.secondary,
    }

    colors.tabline = {
        bg_fill = colors.none,
        fg_fill = colors.none,
        bg = colors.black2,
        fg = colors.grey,
        bg_sel = colors.black,
        fg_sel = colors.primary,
    }

    colors.border_highlight = colors.primary
    colors.border = colors.grey

    colors.comment = colors.grey
    colors.faded = colors.grey

    colors.bg_popup = colors.black2

    colors.bg_statusline = colors.black2
    colors.fg_statusline = colors.fg
    colors.bg_highlight = colors.blue2

    colors.bg_float = colors.bg

    colors.bg_sidebar = (config.transparent_sidebar and colors.none) or colors.black
    colors.fg_sidebar = colors.fg

    colors.bg_visual = colors.grey
    colors.bg_search = colors.primary

    colors.error = colors.red
    colors.warning = colors.yellow
    colors.info = colors.blue
    colors.hint = colors.grey

    return colors
end

return M
