pcall(require, "luarocks.loader")

-- Awesome Libraries --
require("awful.autofocus")
beautiful = require("beautiful")

-- User Libraries --
local config = require("settings") -- declares important global variables
local theme = require("theme")

-- setup
beautiful.init(theme)       -- theme
config.setup()              -- wm settings
