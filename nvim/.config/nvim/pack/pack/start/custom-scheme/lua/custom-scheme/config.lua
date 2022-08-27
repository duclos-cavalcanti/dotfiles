local config

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

local function select_palette(key)
    local key = "custom_" .. key
    local opt = vim.g[key]
    -- local command = string.format("echom '%s'", opt)
    -- vim.cmd(command)
    if opt == nil then
        return "regular"
    elseif  opt == "regular" or
            opt == "dark" or
            opt == "light" or
            opt == "test" then
        return opt
    else
        return "regular"
    end
end

config = {
    transparent = opt("transparent", false),
    transparent_sidebar = opt("transparent_sidebar", false),
    cursorline = opt("cursorline", true),
    columnline = opt("columnline", true),
    comment_style = opt("italic_comments", true) and "italic" or "NONE",
    keyword_style = opt("italic_keywords", true) and "italic" or "NONE",
    function_style = opt("italic_functions", true) and "italic" or "NONE",
    variable_style = opt("italic_variables", false) and "italic" or "NONE",
    hide_inactive_statusline = opt("hide_inactive_statusline", false),
    lualine_bold = opt("lualine_bold", false),
    palette = select_palette("palette"),
}

return config
