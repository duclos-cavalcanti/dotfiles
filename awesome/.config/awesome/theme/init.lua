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
local palette_file    = utils.palette_path() .. "/" .. palette .. ".lua"
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

theme.bg_normal     = colors.wm.generic.normal.bg
theme.bg_focus      = colors.wm.generic.focus.bg
theme.bg_urgent     = colors.wm.generic.urgent.bg
theme.bg_minimize   = colors.wm.generic.min.bg

theme.fg_normal     = colors.wm.generic.normal.fg
theme.fg_focus      = colors.wm.generic.focus.fg
theme.fg_urgent     = colors.wm.generic.urgent.fg
theme.fg_minimize   = colors.wm.generic.min.fg

-- wibar
theme.wibar_bg      = colors.wm.bar.bg
theme.wibar_fg      = colors.wm.bar.fg

-- Systray
theme.bg_systray = colors.wm.tray.bg
theme.systray_popup_bg = colors.wm.tray.popup
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
theme.titlebar_bg_normal     = colors.wm.titlebar.normal
theme.titlebar_bg_focus      = colors.wm.titlebar.focus
theme.titlebar_fg_normal     = colors.fg
theme.titlebar_fg_focus      = colors.fg

-- borders and gaps
theme.useless_gap           = gaps
theme.border_width          = 1
theme.border_normal         = colors.wm.border.normal
theme.border_focus          = colors.wm.border.focus
theme.border_sticky         = colors.wm.border.sticky
-- theme.border_sticky_unfocus = colors.wm.border.sticky_unfocus
theme.border_marked         = colors.wm.border.marked

-- clock
theme.clock = {}
theme.clock.bg = colors.bg
theme.clock.fg = colors.fg

-- taglist
theme.taglist_font          = theme.font_tags
theme.taglist_bg_empty      = colors.wm.tag.empty.bg
theme.taglist_fg_empty      = colors.wm.tag.empty.fg
theme.taglist_bg_occupied   = colors.wm.tag.occ.bg
theme.taglist_fg_occupied   = colors.wm.tag.occ.fg
theme.taglist_bg_focus      = colors.wm.tag.focus.bg
theme.taglist_fg_focus      = colors.wm.tag.focus.fg
theme.taglist_bg_urgent     = colors.wm.tag.urgent.bg
theme.taglist_fg_urgent     = colors.wm.tag.urgent.fg

-- tasklist
theme.tasklist_plain_task_name  = true
theme.tasklist_bg_normal        = colors.wm.tasklist.normal
theme.tasklist_fg_normal        = colors.fg
theme.tasklist_bg_focus         = colors.wm.tasklist.focus
theme.tasklist_fg_focus         = colors.fg
theme.tasklist_bg_urgent        = colors.wm.tasklist.urgent


-- prompt
theme.prompt_prefix         = "run: "
theme.prompt_bg             = colors.wm.prompt.bg
theme.prompt_fg             = colors.wm.prompt.fg
theme.prompt_fg_cursor      = colors.wm.prompt.bg
theme.prompt_bg_cursor      = colors.wm.prompt.fg
theme.prompt_font           = theme.font_prompt

-- menu
theme.menu_height       = dpi(35)
theme.menu_width        = dpi(120)
theme.menu_bg_normal    = colors.wm.menu.normal
theme.menu_bg_focus     = colors.wm.menu.focus.bg
theme.menu_fg_focus     = colors.wm.menu.focus.fg
theme.menu_border_color = colors.wm.menu.focus.border
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
        clock_icon = { icon = "", font = theme.font_icon },
}

return theme
