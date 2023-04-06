local wezterm = require("wezterm")

local M = {}

function M.set_tab_title(title)
    local gui_window = _G.window
    local window = wezterm.mux.get_window(gui_window:window_id())
    for _, tab_info in ipairs(window:tabs_with_info()) do
        if tab_info.is_active then
            tab_info.tab:set_title(title)
            break
        end
    end
end

M.base = {
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },

    { key = 'u', mods = 'ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = 'o', mods = 'ALT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },

	{ key = "j", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "h", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },

	{ key = "h", mods = "ALT|SHIFT", action = wezterm.action({ MoveTabRelative = -1 }) },
	{ key = "l", mods = "ALT|SHIFT", action = wezterm.action({ MoveTabRelative = 1 }) },

    { key = 'n', mods = 'ALT', action = wezterm.action.SpawnWindow },
	{ key = "Enter", mods = "ALT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },

	{ key = "w", mods = "ALT", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "w", mods = "ALT|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },

	{ key = "z", mods = "ALT", action = wezterm.action.TogglePaneZoomState },

	{ key = "=", mods = "CTRL", action = "ResetFontSize" },
	{ key = "+", mods = "CTRL", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },

	{ key = "a", mods = "ALT", action = wezterm.action.ShowLauncher },
	{ key = " ", mods = "ALT", action = wezterm.action.ShowTabNavigator },

    {
      key = ',',
      mods = 'ALT',
      action = wezterm.action.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
    },

    {
      key = 'r',
      mods = "ALT",
      action = wezterm.action.ActivateKeyTable {
        name = 'resize_pane',
        one_shot = false,
      },
    },
}

M.tables = {
  resize_pane = {
    { key = 'h', action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
    { key = 'l', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
    { key = 'k', action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
    { key = 'j', action = wezterm.action.AdjustPaneSize { 'Down', 1 } },

    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },

}

M.mouse = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action({ CompleteSelection = "PrimarySelection" }),
	},
	{
		event = { Up = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action({ CompleteSelection = "Clipboard" }),
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = "OpenLinkAtMouseCursor",
	},
}

return M
