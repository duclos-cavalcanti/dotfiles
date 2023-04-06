local theme = "03"
local theme_path = os.getenv("HOME") .. "/.dotfiles/assets/themes/" .. theme .. ".lua"

if io.open(theme_path,"r") == nil then
    print(string.format("ERROR: The file %s doesn't exist!", theme_path))
    return nil
end

local M = {
    name = theme,
    palette = dofile(theme_path)
}

return M
