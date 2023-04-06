local wezterm = require("wezterm")

local M = {}

M.base = {
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },

    { key = 's', mods = 'ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = 'v', mods = 'ALT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },

	{ key = "j", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "h", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },

	{ key = "t", 
      mods = "ALT", 
      action = wezterm.action_callback(function(win, pane)
                        local tab, window = pane:move_to_new_tab()
                        end)
    },

	{ key = "h", mods = "ALT|SHIFT", action = wezterm.action({ MoveTabRelative = -1 }) },
	{ key = "l", mods = "ALT|SHIFT", action = wezterm.action({ MoveTabRelative = 1 }) },

    { key = 'n', mods = 'ALT', action = wezterm.action.SpawnWindow },
	{ key = "Enter", mods = "ALT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "j", mods = "ALT|SHIFT", action = wezterm.action({ ActivateTabRelative=-1 }) },
	{ key = "k", mods = "ALT|SHIFT", action = wezterm.action({ ActivateTabRelative=1 }) },

	{ key = "w", mods = "ALT", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "w", mods = "ALT|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },

	{ key = "z", mods = "ALT", action = wezterm.action.TogglePaneZoomState },

	{ key = "=", mods = "CTRL", action = "ResetFontSize" },
	{ key = "+", mods = "CTRL", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },

	{ key = " ", mods = "ALT", action = wezterm.action.ShowLauncherArgs{ flags = 'WORKSPACES' } },
	{ key = "t", mods = "ALT|SHIFT", action = wezterm.action.ShowTabNavigator },
	{ key = "c", mods = "ALT|SHIFT", action = wezterm.action.ActivateCommandPalette },
	{ key = "d", mods = "ALT|SHIFT", action = wezterm.action.ShowDebugOverlay },

    { -- rename tab
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

    { -- rename workspace
      key = '4',
      mods = 'ALT',
      action = wezterm.action.PromptInputLine {
        description = 'Enter new name for workspace',
        action = wezterm.action_callback(function(window, pane, line)
        if line then
            wezterm.mux.rename_workspace(
                wezterm.mux.get_active_workspace(),
                line
            )
        end
      end),
      },
    },
    -- search
    { key = "f", mods = "ALT", action = wezterm.action.Search("CurrentSelectionOrEmptyString") },
    { -- activate resize mode
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
