require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()

local scheme = "spaceduck"

-- 'termguicolors' is set in config.lua.
local ok, palette = pcall(require, "theme." .. scheme)
if not ok then
    vim.notify("base16: missing palette lua/theme/" .. scheme .. ".lua", vim.log.levels.ERROR)
    return
end

require("mini.base16").setup({ palette = palette })
