require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()

local DEFAULT = "dark-pastel"
local dir     = vim.uv.fs_realpath(vim.fn.expand("~/.config/theme")) or vim.fn.expand("~/.config/theme")
local pointer = dir .. "/current"

local function selected()
    if vim.fn.filereadable(pointer) ~= 1 then return DEFAULT end
    local name = vim.trim(vim.fn.readfile(pointer)[1] or "")
    return name ~= "" and name or DEFAULT
end

local function load()
    local name = selected()
    package.loaded["theme." .. name] = nil          -- bust require cache (the crux)
    local ok, palette = pcall(require, "theme." .. name)
    if not ok then
        return vim.notify("base16: missing palette lua/theme/" .. name .. ".lua", vim.log.levels.ERROR)
    end
    require("mini.base16").setup({ palette = palette })
end

local function watch()
    local w = vim.uv.new_fs_event()
    if not w then return end
    w:start(dir, {}, vim.schedule_wrap(function(err, name)
        if not err and name == "current" then apply() end
    end))
end

load()
watch()
