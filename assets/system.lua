local function file_exists(name)
    if io.open(name,"r") ~= nil then
        return true
    else
        return false
    end
end

local function system_path()
    return string.format("%s/.dotfiles", os.getenv("HOME"))
end

local colorscheme = "03"
local path = string.format("%s/assets/themes/%s.lua", system_path(), colorscheme)

if not file_exists(path) then
    print(string.format("ERROR: The file %s doesn't exist!", path))
    return nil
end

local M = {
    name = colorscheme,
    palette = dofile(path)
}

return M
