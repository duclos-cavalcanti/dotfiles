local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- theme
for k, v in pairs(require 'theme.custom') do
  config[k] = v
end

-- font
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13.0

-- cursor
config.default_cursor_style = 'SteadyBlock'

-- window
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_padding = { left = 6, right = 6, top = 4, bottom = 4 }
config.window_close_confirmation = 'NeverPrompt'

-- panes
config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }

-- tabs
config.use_fancy_tab_bar = true

-- status
config.status_update_interval = 5000

local function info(script)
  local ok, out = wezterm.run_child_process { wezterm.home_dir .. '/.bin/' .. script }
  return ok and out:match '^%s*(.-)%s*$' or '?'
end

wezterm.on('update-status', function(window)
  local sep = { Color = config.colors.tab_bar.inactive_tab.fg_color }
  window:set_right_status(wezterm.format {
    { Foreground = { AnsiColor = 'Maroon' } },
    { Text = ' disk: ' .. info 'disk-info' },
    { Foreground = sep },
    { Text = '  |  ' },
    { Foreground = { AnsiColor = 'Green' } },
    { Text = 'ram: ' .. info 'ram-info' },
    { Foreground = sep },
    { Text = '  |  ' },
    { Foreground = { AnsiColor = 'Navy' } },
    { Text = 'cpu: ' .. info 'cpu-info' .. ' ' },
    { Text = '  ' },
  })
end)

-- keyboard
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- mouse
config.hide_mouse_cursor_when_typing = true
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelectionOrOpenLinkAtMouseCursor 'ClipboardAndPrimarySelection',
  },
}

-- keybindings
config.keys = {
  -- splits
  { key = 'd', mods = 'CMD',       action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = 'CMD',       action = act.CloseCurrentPane { confirm = false } },

  -- panes
  { key = 'Enter', mods = 'CMD|CTRL',  action = act.TogglePaneZoomState },
  { key = 'Space', mods = 'CMD|SHIFT', action = act.Multiple { act.ActivatePaneDirection 'Next', act.SetPaneZoomState(true) } },
  { key = 'o',     mods = 'CMD',       action = act.ActivatePaneDirection 'Prev' },
  { key = 'o',     mods = 'CMD|SHIFT', action = act.ActivatePaneDirection 'Next' },

  { key = 'k', mods = 'CMD|CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CMD|CTRL', action = act.ActivatePaneDirection 'Down' },
  { key = 'h', mods = 'CMD|CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CMD|CTRL', action = act.ActivatePaneDirection 'Right' },

  { key = 'UpArrow',    mods = 'CMD|CTRL', action = act.AdjustPaneSize { 'Up', 1 } },
  { key = 'DownArrow',  mods = 'CMD|CTRL', action = act.AdjustPaneSize { 'Down', 1 } },
  { key = 'LeftArrow',  mods = 'CMD|CTRL', action = act.AdjustPaneSize { 'Left', 1 } },
  { key = 'RightArrow', mods = 'CMD|CTRL', action = act.AdjustPaneSize { 'Right', 1 } },

  -- tabs
  { key = 't',           mods = 'CMD',            action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'Tab',         mods = 'CTRL',           action = act.ActivateTabRelative(1) },
  { key = 'Tab',         mods = 'CTRL|SHIFT',     action = act.ActivateTabRelative(-1) },
  { key = 'phys:Comma',  mods = 'CMD|CTRL|SHIFT', action = act.MoveTabRelative(-1) },
  { key = 'phys:Period', mods = 'CMD|CTRL|SHIFT', action = act.MoveTabRelative(1) },
  {
    key = 'l', mods = 'CMD',
    action = act.PromptInputLine {
      description = 'Tab title',
      action = wezterm.action_callback(function(window, _, line)
        if line then window:active_tab():set_title(line) end
      end),
    },
  },

  -- config
  { key = 'r', mods = 'CMD', action = act.ReloadConfiguration },
}

for i = 1, 8 do
  table.insert(config.keys, { key = tostring(i), mods = 'CMD', action = act.ActivateTab(i - 1) })
end

return config
