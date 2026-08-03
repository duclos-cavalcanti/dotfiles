require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()

-- Active theme: lua/theme/custom.lua, regenerated from a scheme with
-- `base16 lua <scheme> > lua/theme/custom.lua` (ghostty consumes "custom" too).
local ok, palette = pcall(require, "theme.custom")
if not ok then
    return vim.notify("base16: missing lua/theme/custom.lua", vim.log.levels.ERROR)
end
require("mini.base16").setup({ palette = palette })
