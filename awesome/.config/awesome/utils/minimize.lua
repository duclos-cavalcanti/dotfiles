
local ds = require("utils.ds")
local Stack = ds.Stack

local M = {}

function M.minimize()
    for _, c in ipairs(mouse.screen.selected_tag:clients()) do
        c.minimized = true
    end
end

function M.un_minimize()
    for _, c in ipairs(mouse.screen.selected_tag:clients()) do
        c.minimized = false
    end
end

function M.setup()
end

return M
