local wezterm = require 'wezterm'

local c = {}
local config = dofile(os.getenv("HOME") .. "/.dotfiles/assets/")

if wezterm.config_builder then
  c = wezterm.config_builder()
end

c.color_scheme = 'Batman'
c.enable_wayland = false

return c
