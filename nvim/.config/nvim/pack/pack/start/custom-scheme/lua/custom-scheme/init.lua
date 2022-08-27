local theme = require("custom-scheme.theme")

local M = {}

--- Delete the autocmds when the theme changes to something else
function M.on_colorscheme()
    if vim.g.colors_name ~= "custom" then
        vim.cmd([[autocmd! CustomScheme]])
        vim.cmd([[augroup! CustomScheme]])
    end
end

function M.autocmds(config)
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
    vim.g.terminal_color_7 = colors.grey2
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
    local style = color.style and "gui=" .. color.style or "gui=NONE"
    local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
    local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
    local sp = color.sp and "guisp=" .. color.sp or ""

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

function M.load(theme)
    -- only needed to clear when not the default colorscheme
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    vim.o.termguicolors = true
    vim.g.colors_name = "custom-scheme"

    -- load base theme
    M.syntax(theme.base)
    M.syntax(theme.plugins)
    M.terminal(theme.colors)
    M.autocmds(theme.config)

    vim.defer_fn(function()
        M.syntax(theme.defer)
    end, 100)
end

function M.colorscheme()
    M.load(theme.setup())
end

return M
