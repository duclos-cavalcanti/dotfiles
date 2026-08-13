require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()

local ok, palette = pcall(require, "theme.custom")
if not ok then
    return vim.notify("base16: missing lua/theme/custom.lua", vim.log.levels.ERROR)
end
require("mini.base16").setup({ palette = palette })
