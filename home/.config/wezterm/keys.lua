local wezterm = require("wezterm")

local M = {}

M.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

M.base = {
    { -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
      key = "a",
      mods = "LEADER|CTRL",
      action = wezterm.action.SendString("\x01"),
    },

	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },

    { key = 's', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = 'v', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
	{ key = "t", mods = "LEADER", 
      action = wezterm.action.SplitPane {
          direction = 'Down',
          size = { Percent = 30 },
      }
    },

	{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },

	{ key = "T", mods = "LEADER", action = wezterm.action_callback(function(win, pane) local tab, window = pane:move_to_new_tab() end) },

	{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },

	{ key = "W", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
    { key = 'n', mods = 'LEADER', action = wezterm.action.SpawnWindow },

    {
        key = "Tab",
        mods = "ALT",
        action = wezterm.action_callback(
        function(win, pane) 
            local tab = win:active_tab()
            tab:set_zoomed(false)
            win:perform_action(wezterm.action.RotatePanes("Clockwise"), pane)
            tab:set_zoomed(true)
        end)
     },

	{ key = "j", mods = "ALT", action = wezterm.action({ ActivateTabRelative=-1 }) },
	{ key = "k", mods = "ALT", action = wezterm.action({ ActivateTabRelative=1 }) },
	{ key = "h", mods = "ALT", action = wezterm.action({ MoveTabRelative = -1 }) },
	{ key = "l", mods = "ALT", action = wezterm.action({ MoveTabRelative = 1 }) },

	{ key = "0", mods = "LEADER", action = wezterm.action({ SwitchWorkspaceRelative = -1 }) },
	{ key = "9", mods = "LEADER", action = wezterm.action({ SwitchWorkspaceRelative = 1 }) },

	{ key = "=", mods = "CTRL", action = "ResetFontSize" },
	{ key = "+", mods = "CTRL|SHIFT", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },

	{ key = "w", mods = "LEADER", action = wezterm.action.ShowLauncherArgs{ flags = 'WORKSPACES' } },
	{ key = "d", mods = "LEADER", action = wezterm.action.ShowDebugOverlay },

    { key = "/", mods = "LEADER", action = wezterm.action.Search("CurrentSelectionOrEmptyString") },
    { -- rename tab
      key = ',',
      mods = 'LEADER',
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
      mods = 'LEADER',
      action = wezterm.action.PromptInputLine {
        description = 'Enter new name for workspace',
        action = wezterm.action_callback(function(window, pane, line)
        if line then
            wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
      },
    },
    { -- activate resize mode
      key = 'r',
      mods = "LEADER",
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
    { key = 'Enter', action = 'PopKeyTable' },
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
