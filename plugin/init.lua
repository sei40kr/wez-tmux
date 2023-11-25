local M = {}

local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

M.action = {
  MovePaneToNewTab = wezterm.action_callback(function(_, pane)
    local tab, _ = pane:move_to_new_tab()
    tab:activate()
  end),

  RenameWorkspace = wezterm.action_callback(function(window, pane)
    window:perform_action(act.PromptInputLine({
      description = "Rename workspace: ",
      action = wezterm.action_callback(function(_, _, line)
        if not line or line == "" then
          return
        end

        mux.rename_workspace(mux.get_active_workspace(), line)
      end),
    }), pane)
  end),

  WorkspaceSelect = wezterm.action_callback(function(window, pane)
    local active_workspace = mux.get_active_workspace()
    local workspaces = {
      {
        id = active_workspace,
        label = active_workspace,
      },
    }

    for _, workspace in ipairs(mux.get_workspace_names()) do
      if workspace ~= active_workspace then
        table.insert(workspaces, {
          id = workspace,
          label = workspace,
        })
      end
    end

    window:perform_action(act.InputSelector({
      title = "Select Workspace",
      choices = workspaces,
      action = wezterm.action_callback(function(_, _, id, _)
        if not id then
          return
        end

        mux.set_active_workspace(id)
      end),
    }), pane)
  end),
}

---@param config unknown
---@param _ { }
function M.apply_to_config(config, _)
  if not config.leader then
    config.leader = { key = "b", mods = "CTRL" }
    wezterm.log_warn("No leader key set, using default: Ctrl-b")
  end

  local keys = {
    { key = config.leader.key, mods = "LEADER|" .. config.leader.mods, action = act.SendKey(config.leader) },

    -- Workspaces
    { key = "$",               mods = "LEADER",                        action = M.action.RenameWorkspace },
    { key = "s",               mods = "LEADER",                        action = M.action.WorkspaceSelect },
    { key = "(",               mods = "LEADER",                        action = act.SwitchWorkspaceRelative(-1) },
    { key = ")",               mods = "LEADER",                        action = act.SwitchWorkspaceRelative(1) },

    -- Tabs
    { key = "c",               mods = "LEADER",                        action = act.SpawnTab("CurrentPaneDomain") },
    { key = "&",               mods = "LEADER",                        action = act.CloseCurrentTab({ confirm = true }) },
    { key = "p",               mods = "LEADER",                        action = act.ActivateTabRelative(-1) },
    { key = "n",               mods = "LEADER",                        action = act.ActivateTabRelative(1) },
    { key = "l",               mods = "LEADER",                        action = act.ActivateLastTab },

    -- Panes
    {
      key = "%",
      mods = "LEADER",
      action = act.SplitHorizontal({
        domain = "CurrentPaneDomain" })
    },
    {
      key = "\"",
      mods = "LEADER",
      action = act.SplitVertical({
        domain = "CurrentPaneDomain" })
    },
    { key = "{",          mods = "LEADER",      action = act.RotatePanes("CounterClockwise") },
    { key = "}",          mods = "LEADER",      action = act.RotatePanes("Clockwise") },
    { key = "LeftArrow",  mods = "LEADER",      action = act.ActivatePaneDirection("Left") },
    { key = "DownArrow",  mods = "LEADER",      action = act.ActivatePaneDirection("Down") },
    { key = "UpArrow",    mods = "LEADER",      action = act.ActivatePaneDirection("Up") },
    { key = "RightArrow", mods = "LEADER",      action = act.ActivatePaneDirection("Right") },
    { key = "q",          mods = "LEADER",      action = act.PaneSelect({ mode = "Activate" }) },
    { key = "z",          mods = "LEADER",      action = act.TogglePaneZoomState },
    { key = "!",          mods = "LEADER",      action = M.action.MovePaneToNewTab },
    { key = "LeftArrow",  mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "DownArrow",  mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "UpArrow",    mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "RightArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Right", 5 }) },
    { key = "x",          mods = "LEADER",      action = act.CloseCurrentPane({ confirm = true }) },

    -- Copy Mode
    { key = "[",          mods = "LEADER",      action = act.ActivateCopyMode },
  }

  for i = 1, 9 do
    table.insert(keys, { key = tostring(i), mods = "LEADER", action = act.ActivateTab(i - 1) })
  end

  if not config.keys then
    config.keys = {}
  end
  for _, key in ipairs(keys) do
    table.insert(config.keys, key)
  end
end

return M
