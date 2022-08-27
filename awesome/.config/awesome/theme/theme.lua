---------------------------
-- Custom awesome theme --
---------------------------
local dpi = require("beautiful.xresources").apply_dpi

local utils = require("utils")
local config_path = utils.config_path

local theme_path = config_path() .. "theme"
local icon_path = theme_path .. "/icons"
local wallpaper_path = theme_path .. "/wallpapers"
local default_path = require("gears.filesystem").get_themes_dir()

local wp = wallpaper_path .. "/" .. wallpaper
local theme = {}

theme.wallpaper     = wp
theme.colors        = colors

theme.font_family   = font_family .. " "
theme.font          = theme.font_family .. "9"
theme.font_icon     = theme.font_family .. "6"

theme.bg_normal     = colors.black2
theme.bg_focus      = colors.black2
theme.bg_urgent     = colors.red
theme.bg_minimize   = colors.magenta
theme.bg_systray    = theme.bg_normal

-- wibar
theme.wibar_bg      = colors.bg
theme.wibar_fg      = colors.foreground

-- Systray
theme.bg_systray = colors.bg
theme.systray_popup_bg = colors.black2
theme.systray_icon_spacing = dpi(3)
theme.systray_icon_size = dpi(15)
theme.systray_max_rows = 1

-- Notifications
beautiful.notification_font = theme.font_family .. "9"
-- beautiful.notification_shape = gears.shape
beautiful.notification_bg = colors.bg
beautiful.notification_fg = colors.blue
beautiful.notification_border_width = 2
beautiful.notification_border_color = colors.red
beautiful.notification_opacity = 90
beautiful.notification_margin = 10
beautiful.notification_width = 100
beautiful.notification_height = 50
beautiful.notification_max_width = 100
beautiful.notification_max_height = 50
beautiful.notification_icon_size = 20

-- Separator
theme.separator_bg1 = colors.black
theme.separator_bg2 = colors.black2

-- titlebars
-- theme.titlebar_icon          = icon_path .. "/ghost.png"
theme.titlebar_size          = 0 -- 20
theme.titlebar_bg_normal     = colors.black
theme.titlebar_bg_focus      = colors.black
theme.titlebar_fg_normal     = colors.foreground
theme.titlebar_fg_focus      = colors.foreground

theme.fg_normal     = colors.foreground
theme.fg_focus      = colors.foreground
theme.fg_urgent     = colors.red
theme.fg_minimize   = colors.foreground

-- borders and gaps
theme.useless_gap   = dpi(1) -- gaps
theme.border_width  = dpi(1)
theme.border_normal = colors.black2
theme.border_focus  = colors.white2
theme.border_marked = colors.red

-- taglist
theme.taglist_font          = theme.font_family .. "10"
theme.taglist_bg_empty      = colors.bg
theme.taglist_fg_empty      = colors.grey
theme.taglist_bg_occupied   = colors.bg
theme.taglist_fg_occupied   = colors.foreground
theme.taglist_bg_focus      = colors.grey
theme.taglist_fg_focus      = colors.bg
theme.taglist_bg_urgent     = colors.red
theme.taglist_fg_urgent     = colors.foreground

-- tasklist
theme.tasklist_bg_normal     = colors.black
theme.tasklist_fg_normal     = colors.fg
theme.tasklist_bg_focus      = colors.black2
theme.tasklist_fg_focus      = colors.fg
theme.tasklist_bg_urgent     = colors.red


-- prompt
theme.prompt_bg             = colors.bg
theme.prompt_fg             = colors.foreground
theme.prompt_fg_cursor      = colors.bg
theme.prompt_bg_cursor      = colors.bg
theme.prompt_font           = "DejaVuSansMono 10"

-- menu
-- theme.menu_submenu_icon = theme_path .. "/icons" .. "/pacman.png"
theme.menu_height       = dpi(22)
theme.menu_width        = dpi(120)
theme.menu_bg           = colors.bg
theme.menu_bg_focus     = colors.black
theme.menu_fg_focus     = colors.blue
theme.menu_border_color = colors.white
theme.menu_border_width = 2

-- icons
-- https://github.com/tdy/awesome/
theme.taglist_squares_sel   = theme_path .. "/icons" .. "/tags" .. "/squaref.png"
theme.taglist_squares_unsel = theme_path .. "/icons" .. "/tags" .. "/square.png"

-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(dpi(5), colors.blue)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(dpi(5), colors.white2)

-- https://github.com/tdy/awesome/
theme.layout_tile           = icon_path .. "/layouts" .. "/tilew.png"
theme.layout_tileleft       = icon_path .. "/layouts" .. "/tileleftw.png"
theme.layout_tilebottom     = icon_path .. "/layouts" .. "/tilebottomw.png"
theme.layout_tiletop        = icon_path .. "/layouts" .. "/tiletopw.png"
theme.layout_fairv          = icon_path .. "/layouts" .. "/fairvw.png"
theme.layout_fairh          = icon_path .. "/layouts" .. "/fairhw.png"
theme.layout_spiral         = icon_path .. "/layouts" .. "/spiralw.png"
theme.layout_dwindle        = icon_path .. "/layouts" .. "/dwindlew.png"
theme.layout_max            = icon_path .. "/layouts" .. "/maxw.png"
theme.layout_fullscreen     = icon_path .. "/layouts" .. "/fullscreenw.png"
theme.layout_magnifier      = icon_path .. "/layouts" .. "/magnifierw.png"
theme.layout_floating       = icon_path .. "/layouts" .. "/floatingw.png"

theme.custom_icons = {
        menu_icon = { icon = "", font = theme.font_icon },
        memory_icon = { icon = "", font = theme.font_icon }
}

theme.menu_icon     = icon_path .. "/menu_orange.png"
theme.ghost_icon    = icon_path .. "/arch_small.png"
-- theme.awesome_icon = icon_path .. "/terminal.png"
-- theme.icon_theme = nil

return theme
