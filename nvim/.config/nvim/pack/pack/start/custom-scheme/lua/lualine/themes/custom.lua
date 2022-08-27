local config = require("custom-scheme.config")
local theme = require("custom-scheme.theme").setup(config)

local custom = {}

custom = theme.lualine

if config.custom_lualine_bold then
    for _, mode in pairs(custom) do
        mode.a.gui = "bold"
    end
end

return custom
