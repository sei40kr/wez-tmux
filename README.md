# wez-tmux

Port [tmux](https://github.com/tmux/tmux) key bindings to [WezTerm](https://wezfurlong.org/wezterm).

## Installation

Clone this repository to your `$XDG_CONFIG_HOME/wezterm`:

```sh
git clone https://github.com/sei40kr/wez-tmux.git $XDG_CONFIG_HOME/wezterm
```

## Usage

```lua
local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Add these lines:
require("wez-tmux.plugin").apply_to_config(config, {})

return config
```

## Options

**Default Options**

```lua
require("wez-tmux.plugin").apply_to_config(config, {
    leader = { key = "b", mods = "CTRL" },
})
```

---

| Option   | Default                        | Description |
| -------- | ------------------------------ | ----------- |
| `leader` | `{ key = "b", mods = "CTRL" }` | Leader key  |

## Key Bindings

| Key             | Action                                                             |
| --------------- | ------------------------------------------------------------------ |
| `leader+leader` | Send `leader` key                                                  |
| `leader+[`      | Activate [Copy Mode](https://wezfurlong.org/wezterm/copymode.html) |

### Tabs

| Key           | Action                                  |
| ------------- | --------------------------------------- |
| `leader+c`    | Create a new tab in the current window  |
| `leader+,`    | Unsupported                             |
| `leader+&`    | Close the current tab                   |
| `leader+w`    | Unsupported                             |
| `leader+p`    | Activate the previous tab               |
| `leader+n`    | Activate the next tab                   |
| `leader+1..9` | Activate the tab at the specified index |
| `leader+l`    | Activate the previously active tab      |

### Panes

| Key                 | Action                                         |
| ------------------- | ---------------------------------------------- |
| `leader+%`          | Split the current pane horizontally            |
| `leader+"`          | Split the current pane vertically              |
| `leader+{`          | Rotate the sequence of panes counter-clockwise |
| `leader+}`          | Rotate the sequence of panes clockwise         |
| `leader+left`       | Activate the pane to the left                  |
| `leader+down`       | Activate the pane below                        |
| `leader+up`         | Activate the pane above                        |
| `leader+right`      | Activate the pane to the right                 |
| `leader+q`          | Activate the pane selection modal display      |
| `leader+z`          | Toggle the zoom state of the current pane      |
| `leader+ctrl+left`  | Resize the current pane to the left            |
| `leader+ctrl+down`  | Resize the current pane below                  |
| `leader+ctrl+up`    | Resize the current pane above                  |
| `leader+ctrl+right` | Resize the current pane to the right           |
| `leader+x`          | Close the current pane                         |
