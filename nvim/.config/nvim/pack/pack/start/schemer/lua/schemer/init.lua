local theme = require("schemer.theme")

local M = {}

local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
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
    vim.g.colors_name = "schemer"

    -- load scheme highlights
    M.syntax(t)
    vim.defer_fn(function()
        M.syntax(defer)
    end, 100
    )

    -- load terminal highlights
    M.terminal(colors)
end

function M.setup(config, palette)
    local rc = dofile(palette)
    if rc ~= nil then
        M.load(theme.setup(config, rc.palette))
    end
end

return M
