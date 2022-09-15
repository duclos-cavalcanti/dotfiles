local theme = require("custom-scheme.theme")

local M = {}

function M.on_colorscheme()
    -- delete the autocommands when the theme changes
    if vim.g.colors_name ~= "custom" then
        vim.cmd([[autocmd! CustomScheme]])
        vim.cmd([[augroup! CustomScheme]])
    end
end

function M.autocmds()
    vim.cmd([[augroup CustomScheme]])
    vim.cmd([[  autocmd!]])
    vim.cmd([[  autocmd ColorScheme * lua require("custom-scheme").on_colorscheme()]])
    vim.cmd([[augroup end]])
end

function M.terminal(colors)
    -- dark
    vim.g.terminal_color_0 = colors.bg
    vim.g.terminal_color_8 = colors.black

    -- light
    vim.g.terminal_color_7 = colors.grey
    vim.g.terminal_color_15 = colors.fg

    -- colors
    vim.g.terminal_color_1 = colors.red
    vim.g.terminal_color_9 = colors.red2

    vim.g.terminal_color_2 = colors.green
    vim.g.terminal_color_10 = colors.green2

    vim.g.terminal_color_3 = colors.yellow
    vim.g.terminal_color_11 = colors.yellow2

    vim.g.terminal_color_4 = colors.blue
    vim.g.terminal_color_12 = colors.blue2

    vim.g.terminal_color_5 = colors.magenta
    vim.g.terminal_color_13 = colors.magenta2

    vim.g.terminal_color_6 = colors.cyan
    vim.g.terminal_color_14 = colors.cyan2
end

function M.highlight(group, color)
    local style = color.style   and "gui="   .. color.style or "gui=NONE"
    local fg    = color.fg      and "guifg=" .. color.fg    or "guifg=NONE"
    local bg    = color.bg      and "guibg=" .. color.bg    or "guibg=NONE"
    local sp    = color.sp      and "guisp=" .. color.sp    or ""

    local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp

    if color.link then
        vim.cmd("highlight! link " .. group .. " " .. color.link)
    else
        vim.cmd(hl)
    end
end

function M.syntax(syntax)
    for group, colors in pairs(syntax) do
        M.highlight(group, colors)
    end
end

function M.load(t, defer, colors)
    -- only needed to clear when not the default colorscheme
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    vim.o.termguicolors = true
    vim.g.colors_name = "custom-scheme"

    -- auto commands
    M.autocmds()

    -- load scheme highlights
    M.syntax(t)
    vim.defer_fn(function()
        M.syntax(defer)
    end, 100
    )

    -- load terminal highlights
    M.terminal(colors)
end

function M.colors(palette_dir, palette)
    return dofile(string.format("%s/%s.lua", palette_dir, palette))
end

function M.config()
    vim = vim or { g = {}, o = {} }
    local function opt(key, default)
        local key = "custom_" .. key
        if vim.g[key] == nil then
            return default
        end
        if vim.g[key] == 0 then
            return false
        end
        return vim.g[key]
    end

    local function select_palette()
        local key = "custom_palette"
        local opt = vim.g[key]
        if opt == "regular" or
           opt == "dark"    or
           opt == "light"   or
           opt == "test" then
            return opt
        else
            return "regular"
        end
    end

    local function get_palette_dir()
        local dir = vim.g["custom_palette_dir"]
        return dir
    end

    local config = {
        palette_dir                 = get_palette_dir(),
        palette                     = select_palette(),
        transparent                 = opt("transparent", false),
        cursorline                  = opt("cursorline", true),
        colorcolumn                 = opt("colorcolumn", true),
        columnline                  = opt("columnline", false),
        comment_style               = opt("italic_comments", true) and "italic" or "NONE",
        keyword_style               = opt("italic_keywords", true) and "italic" or "NONE",
        function_style              = opt("italic_functions", true) and "italic" or "NONE",
        variable_style              = opt("italic_variables", false) and "italic" or "NONE",
        inactive_statusline         = opt("inactive_statusline", false),
        lualine_bold                = opt("lualine_bold", false),
    }

    return config
end

function M.colorscheme()
    local config = M.config()
    local colors = M.colors(config.palette_dir, config.palette)
    M.load(theme.setup(config, colors))
end

return M
