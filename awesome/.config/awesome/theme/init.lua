-- Custom awesome theme --
---------------------------
local dpi = require("beautiful.xresources").apply_dpi
local theme_assets = require("beautiful.theme_assets")

local utils = require("utils")
local config_path = utils.config_path

local theme_path = config_path() .. "theme"
local wallpaper_path = theme_path .. "/wallpapers"
local icon_path = theme_path .. "/icons"

local font_family     = "UbuntuMono"

local config          = dofile(utils.home_path() .. "/.dotfiles/assets/system.lua")
local palette         = config.palette

local theme = {}

theme.colors        = palette
theme.wp            = wallpaper_path .. "/" .. palette.wm.wp
theme.wp2           = wallpaper_path .. "/" .. (palette.wm.wp2 or palette.wm.wp)
theme.none          = "#0000000" -- transparency

theme.font_family       = font_family .. " "
theme.font              = theme.font_family .. "9"
theme.font_icon         = theme.font_family .. "9"
theme.font_tags         = theme.font_family .. "9"
theme.font_clock        = theme.font_family .. "8"
theme.font_prompt       = theme.font_family .. "10"
theme.font_notification = theme.font_family .. "9"

-- default
theme.bg_normal     = palette.wm.generic.normal.bg
theme.fg_normal     = palette.wm.generic.normal.fg
theme.bg_focus      = palette.wm.generic.focus.bg
theme.fg_focus      = palette.wm.generic.focus.fg
theme.bg_urgent     = palette.wm.generic.urgent.bg
theme.fg_urgent     = palette.wm.generic.urgent.fg
theme.bg_minimize   = palette.wm.generic.min.bg
theme.fg_minimize   = palette.wm.generic.min.fg

-- wibar
theme.wibar_bg              = palette.wm.bar.bg
theme.wibar_fg              = palette.wm.bar.fg
theme.wibar_fg_highlight    = palette.wm.bar.highlight

-- Systray
theme.bg_systray = palette.wm.tray.bg
theme.fg_systray = palette.wm.tray.fg
theme.systray_popup_bg = palette.wm.tray.popup
theme.systray_icon_spacing = dpi(3)
theme.systray_icon_size = dpi(20)
theme.systray_max_rows = 1

-- Notifications
beautiful.notification_font = theme.font_notification
beautiful.notification_bg = palette.wm.notification.bg
beautiful.notification_fg = palette.wm.notification.fg
beautiful.notification_border_width = 2
beautiful.notification_border_color = palette.wm.notification.border
beautiful.notification_opacity = 90
beautiful.notification_margin = 10
beautiful.notification_width = 50
beautiful.notification_height = 50
beautiful.notification_max_width = 60
beautiful.notification_max_height = 35
beautiful.notification_icon_size = 5

-- Separator
theme.separator_fg = palette.wm.separator

-- titlebars
theme.titlebar_bg_normal     = palette.wm.titlebar.normal.bg
theme.titlebar_bg_focus      = palette.wm.titlebar.focus.bg
theme.titlebar_fg_normal     = palette.wm.titlebar.normal.fg
theme.titlebar_fg_focus      = palette.wm.titlebar.focus.fg

-- borders and gaps
theme.useless_gap           = gaps
theme.border_width          = border_width
theme.border_normal         = palette.wm.border.normal
theme.border_focus          = palette.wm.border.focus
theme.border_sticky         = palette.wm.border.sticky
theme.border_marked         = palette.wm.border.marked

-- clock
theme.clock = {}
theme.clock.bg = palette.wm.clock.bg
theme.clock.fg = palette.wm.clock.fg

-- taglist
theme.taglist_font          = theme.font_tags
theme.taglist_bg_empty      = palette.wm.tag.empty.bg
theme.taglist_fg_empty      = palette.wm.tag.empty.fg
theme.taglist_bg_occupied   = palette.wm.tag.occ.bg
theme.taglist_fg_occupied   = palette.wm.tag.occ.fg
theme.taglist_bg_focus      = palette.wm.tag.focus.bg
theme.taglist_fg_focus      = palette.wm.tag.focus.fg
theme.taglist_bg_urgent     = palette.wm.tag.urgent.bg
theme.taglist_fg_urgent     = palette.wm.tag.urgent.fg

-- tasklist
theme.tasklist_plain_task_name  = true
theme.tasklist_bg_normal        = palette.wm.generic.normal.bg
theme.tasklist_fg_normal        = palette.wm.generic.normal.fg
theme.tasklist_bg_focus         = palette.wm.generic.focus.bg
theme.tasklist_fg_focus         = palette.wm.generic.focus.fg
theme.tasklist_bg_urgent        = palette.wm.generic.urgent.bg
theme.tasklist_fg_urgent        = palette.wm.generic.urgent.fg


-- prompt
theme.prompt_prefix         = "run: "
theme.prompt_bg             = palette.wm.prompt.bg
theme.prompt_fg             = palette.wm.prompt.fg
theme.prompt_fg_cursor      = palette.wm.prompt.bg
theme.prompt_bg_cursor      = palette.wm.prompt.fg
theme.prompt_font           = theme.font_prompt

-- menu
theme.menu_height       = dpi(35)
theme.menu_width        = dpi(120)
theme.menu_bg_normal    = palette.wm.menu.normal
theme.menu_bg_focus     = palette.wm.menu.focus.bg
theme.menu_fg_focus     = palette.wm.menu.focus.fg
theme.menu_border_color = palette.wm.menu.focus.border
theme.menu_border_width = 3
theme.menu_submenu = "> "

-- icons
-- https://github.com/tdy/awesome/
-- theme.taglist_squares_sel   = nil
-- theme.taglist_squares_unsel = nil
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
theme.menu_icon     = icon_path .. "/menu.png"

return theme
