---------------------------
-- Custom awesome theme --
---------------------------
local dpi = require("beautiful.xresources").apply_dpi
local theme_assets = require("beautiful.theme_assets")

local utils = require("utils")
local config_path = utils.config_path

local theme_path = config_path() .. "theme"
local icon_path = theme_path .. "/icons"
local default_path = require("gears.filesystem").get_themes_dir()

local font_family     = "Iosevka" -- DejaVuSansMono
local palette         = "dark"
local palette_file    = utils.palette_path() .. palette .. ".lua"
local colors          = utils.load_file(palette_file)

local theme = {}

theme.colors        = colors
theme.none          = "#0000000" -- transperency

theme.font_family       = font_family .. " "
theme.font              = theme.font_family .. "9"
theme.font_icon         = theme.font_family .. "6"
theme.font_tags         = theme.font_family .. "9"
theme.font_clock        = theme.font_family .. "8"
theme.font_prompt       = theme.font_family .. "10"
theme.font_notification = theme.font_family .. "9"

theme.bg_normal     = colors.black2
theme.bg_focus      = colors.black2
theme.bg_urgent     = colors.red
theme.bg_minimize   = colors.magenta

theme.fg_normal     = colors.fg
theme.fg_focus      = colors.fg
theme.fg_urgent     = colors.red2
theme.fg_minimize   = colors.fg

-- wibar
theme.wibar_bg      = colors.wm.bar.bg
theme.wibar_fg      = colors.wm.bar.fg

-- Systray
theme.bg_systray = colors.bg
theme.systray_popup_bg = colors.black2
theme.systray_icon_spacing = dpi(3)
theme.systray_icon_size = dpi(20)
theme.systray_max_rows = 1

-- Notifications
beautiful.notification_font = theme.font_notification
beautiful.notification_bg = colors.wm.notification.bg
beautiful.notification_fg = colors.wm.notification.fg
beautiful.notification_border_width = 2
beautiful.notification_border_color = colors.wm.notification.border
beautiful.notification_opacity = 90
beautiful.notification_margin = 10
beautiful.notification_width = 100
beautiful.notification_height = 50
beautiful.notification_max_width = 100
beautiful.notification_max_height = 50
beautiful.notification_icon_size = 5

-- Separator
theme.separator_fg = colors.wm.separator

-- titlebars
theme.titlebar_size          = 0 -- 20
theme.titlebar_bg_normal     = colors.wm.titlebar.normal
theme.titlebar_bg_focus      = colors.wm.titlebar.focus
theme.titlebar_fg_normal     = colors.fg
theme.titlebar_fg_focus      = colors.fg

-- borders and gaps
theme.useless_gap           = gaps
theme.border_width          = 1
theme.border_normal         = colors.black2
theme.border_focus          = colors.fg
theme.border_sticky         = colors.green
theme.border_sticky_unfocus = colors.green2
theme.border_marked         = colors.blue

-- clock
theme.clock = {}
theme.clock.bg = colors.bg
theme.clock.fg = colors.fg

-- taglist
theme.taglist_font          = theme.font_tags
theme.taglist_bg_empty      = colors.bg
theme.taglist_fg_empty      = colors.grey
theme.taglist_bg_occupied   = colors.bg
theme.taglist_fg_occupied   = colors.grey2
theme.taglist_bg_focus      = colors.grey
theme.taglist_fg_focus      = colors.fg
theme.taglist_bg_urgent     = colors.red
theme.taglist_fg_urgent     = colors.fg

-- tasklist
theme.tasklist_plain_task_name  = true
theme.tasklist_bg_normal        = colors.black
theme.tasklist_fg_normal        = colors.fg
theme.tasklist_bg_focus         = colors.black2
theme.tasklist_fg_focus         = colors.fg
theme.tasklist_bg_urgent        = colors.red


-- prompt
theme.prompt_prefix         = "run: "
theme.prompt_bg             = colors.bg
theme.prompt_fg             = colors.fg
theme.prompt_fg_cursor      = colors.bg
theme.prompt_bg_cursor      = colors.bg
theme.prompt_font           = theme.font_prompt

-- menu
theme.menu_height       = dpi(35)
theme.menu_width        = dpi(120)
theme.menu_bg_normal    = colors.bg
theme.menu_bg_focus     = colors.black2
theme.menu_fg_focus     = colors.fg
theme.menu_border_color = colors.white
theme.menu_border_width = 3

-- icons
-- https://github.com/tdy/awesome/
-- theme.taglist_squares_sel   = nil
-- theme.taglist_squares_unsel = nil
theme.taglist_squares_sel   = theme_path .. "/icons" .. "/tags" .. "/squaref.png"
theme.taglist_squares_unsel = theme_path .. "/icons" .. "/tags" .. "/square.png"
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

theme.icon_theme = nil
theme.awesome_icon  = icon_path .. "/awesome.png"
theme.arch_icon     = icon_path .. "/arch.png"
theme.menu_icon     = icon_path .. "/square.png"

theme.custom_icons = {
        menu_icon = { icon = "", font = theme.font_icon },
        memory_icon = { icon = "", font = theme.font_icon },
        clock_icon = { icon = "", font = theme.font_icon },
}

return theme
