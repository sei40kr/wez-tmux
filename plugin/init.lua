local M = {}

local wezterm = require("wezterm")
local act = wezterm.action

---@param config unknown
---@param _ { }
function M.apply_to_config(config, _)
  if not config.leader then
    config.leader = { key = "b", mods = "CTRL" }
    wezterm.log_warn("No leader key set, using default: Ctrl-b")
  end

  local keys = {
    { key = config.leader.key, mods = "LEADER|" .. config.leader.mods, action = act.SendKey(config.leader) },

    -- Tabs
    { key = "c",               mods = "LEADER",                        action = act.SpawnTab("CurrentPaneDomain") },
    { key = "&",               mods = "LEADER",                        action = act.CloseCurrentTab({ confirm = true }) },
    { key = "p",               mods = "LEADER",                        action = act.ActivateTabRelative(-1) },
    { key = "n",               mods = "LEADER",                        action = act.ActivateTabRelative(1) },
    { key = "l",               mods = "LEADER",                        action = act.ActivateLastTab },

    -- Panes
    { key = "%",               mods = "LEADER",                        action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "\"",              mods = "LEADER",                        action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "{",               mods = "LEADER",                        action = act.RotatePanes("CounterClockwise") },
    { key = "}",               mods = "LEADER",                        action = act.RotatePanes("Clockwise") },
    { key = "LeftArrow",       mods = "LEADER",                        action = act.ActivatePaneDirection("Left") },
    { key = "DownArrow",       mods = "LEADER",                        action = act.ActivatePaneDirection("Down") },
    { key = "UpArrow",         mods = "LEADER",                        action = act.ActivatePaneDirection("Up") },
    { key = "RightArrow",      mods = "LEADER",                        action = act.ActivatePaneDirection("Right") },
    { key = "q",               mods = "LEADER",                        action = act.PaneSelect({ mode = "Activate" }) },
    { key = "z",               mods = "LEADER",                        action = act.TogglePaneZoomState },
    { key = "LeftArrow",       mods = "LEADER|CTRL",                   action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "DownArrow",       mods = "LEADER|CTRL",                   action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "UpArrow",         mods = "LEADER|CTRL",                   action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "RightArrow",      mods = "LEADER|CTRL",                   action = act.AdjustPaneSize({ "Right", 5 }) },
    { key = "x",               mods = "LEADER",                        action = act.CloseCurrentPane({ confirm = true }) },

    -- Copy Mode
    { key = "[",               mods = "LEADER",                        action = act.ActivateCopyMode },
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
