---------------------------
-- Custom awesome theme --
---------------------------
local dpi = require("beautiful.xresources").apply_dpi
local theme_assets = require("beautiful.theme_assets")

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

theme.font_family       = font_family .. " "
theme.font              = theme.font_family .. "9"
theme.font_icon         = theme.font_family .. "6"
theme.font_tags         = theme.font_family .. "10"
theme.font_prompt       = theme.font_family .. "10"
theme.font_notification = theme.font_family .. "9"

theme.bg_normal     = colors.black2
theme.bg_focus      = colors.black2
theme.bg_urgent     = colors.red
theme.bg_minimize   = colors.magenta

-- wibar
theme.wibar_bg      = colors.bg
theme.wibar_fg      = colors.foreground

-- Systray
theme.bg_systray = colors.bg
theme.systray_popup_bg = colors.black2
theme.systray_icon_spacing = dpi(5)
theme.systray_icon_size = dpi(15)
theme.systray_max_rows = 1

-- Notifications
beautiful.notification_font = theme.font_notification
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
theme.separator_fg = colors.black

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
theme.useless_gap   = gaps
theme.border_width  = 1
theme.border_normal = colors.black2
theme.border_focus  = colors.grey
theme.border_sticky = colors.red
theme.border_sticky_unfocus = colors.white
theme.border_marked = colors.blue

-- taglist
theme.taglist_font          = theme.font_tags
theme.taglist_bg_empty      = colors.bg
theme.taglist_fg_empty      = colors.grey
theme.taglist_bg_occupied   = colors.bg
theme.taglist_fg_occupied   = colors.foreground
theme.taglist_bg_focus      = colors.grey
theme.taglist_fg_focus      = colors.bg
theme.taglist_bg_urgent     = colors.red
theme.taglist_fg_urgent     = colors.foreground

-- tasklist
theme.tasklist_plain_task_name  = true
theme.tasklist_bg_normal        = colors.black
theme.tasklist_bg_normal        = colors.black
theme.tasklist_fg_normal        = colors.fg
theme.tasklist_bg_focus         = colors.black2
theme.tasklist_fg_focus         = colors.fg
theme.tasklist_bg_urgent        = colors.red


-- prompt
theme.prompt_prefix         = " > "
theme.prompt_bg             = colors.bg
theme.prompt_fg             = colors.foreground
theme.prompt_fg_cursor      = colors.bg
theme.prompt_bg_cursor      = colors.bg
theme.prompt_font           = theme.font_prompt

-- menu
theme.menu_height       = dpi(20)
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
        memory_icon = { icon = "", font = theme.font_icon },
        clock_icon = { icon = "", font = theme.font_icon },
}

theme.awesome_icon  = icon_path .. "/awesome.png"
theme.arch_icon     = icon_path .. "/arch.png"
theme.ghost_icon    = icon_path .. "/ghost.png"
theme.menu_icon     = icon_path .. "/menu.png"
-- theme.icon_theme = nil

return theme
