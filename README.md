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

-- If you have your own leader key, make sure to set it before loading this
-- plugin.
config.leader = { key = "b", mods = "CTRL" }

-- Add these lines:
require("wez-tmux.plugin").apply_to_config(config, {})

return config
```

## Key Bindings

| Key             | Action                                                             |
| --------------- | ------------------------------------------------------------------ |
| `leader+leader` | Send `leader` key                                                  |
| `leader+[`      | Activate [Copy Mode](https://wezfurlong.org/wezterm/copymode.html) |

### Workspaces

| Key        | Action                                         |
| ---------- | ---------------------------------------------- |
| `leader+$` | Rename the active workspace                    |
| `leader+d` | Unsupported                                    |
| `leader+s` | List workspaces and switch to the selected one |
| `leader+w` | Unsupported                                    |
| `leader+(` | Switch to the previous workspace               |
| `leader+)` | Switch to the next workspace                   |

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

| Key                 | Action                                                                          |
| ------------------- | ------------------------------------------------------------------------------- |
| `leader+%`          | Split the current pane horizontally                                             |
| `leader+"`          | Split the current pane vertically                                               |
| `leader+{`          | Rotate the sequence of panes counter-clockwise                                  |
| `leader+}`          | Rotate the sequence of panes clockwise                                          |
| `leader+left`       | Activate the pane to the left                                                   |
| `leader+down`       | Activate the pane below                                                         |
| `leader+up`         | Activate the pane above                                                         |
| `leader+right`      | Activate the pane to the right                                                  |
| `leader+q`          | Activate the pane selection modal display                                       |
| `leader+z`          | Toggle the zoom state of the current pane                                       |
| `leader+!`          | Create a new tab in the current window and moves the current pane into that tab |
| `leader+ctrl+left`  | Resize the current pane to the left                                             |
| `leader+ctrl+down`  | Resize the current pane below                                                   |
| `leader+ctrl+up`    | Resize the current pane above                                                   |
| `leader+ctrl+right` | Resize the current pane to the right                                            |
| `leader+x`          | Close the current pane                                                          |

### Misc

| Key            | Action                                                                        |
| -------------- | ----------------------------------------------------------------------------- |
| `leader+space` | Activate [Quick Select Mode](https://wezfurlong.org/wezterm/quickselect.html) |

### Copy Mode

| Key       | Action                                                  |
| --------- | ------------------------------------------------------- |
| `y`       | Copy and exit copy mode                                 |
| `escape`  | Clear selection / Clear search pattern / Exit copy mode |
| `v`       | Cell selection                                          |
| `shift+v` | Line selection                                          |
| `ctrl+v`  | Rectangular selection                                   |
| `h`       | Move Left                                               |
| `j`       | Move Down                                               |
| `k`       | Move Up                                                 |
| `l`       | Move Right                                              |
| `w`       | Move forward one word                                   |
| `b`       | Move backward one word                                  |
| `e`       | Move forward one word end                               |
| `0`       | Move to start of this line                              |
| `$`       | Move to end of this line                                |
| `^`       | Move to start of indented line                          |
| `shift+g` | Move to bottom of scrollback                            |
| `g`       | Move to top of scrollback                               |
| `shift+h` | Move to top of viewport                                 |
| `shift+m` | Move to middle of viewport                              |
| `shift+l` | Move to bottom of viewport                              |
| `ctrl+b`  | Move up one screen                                      |
| `ctrl+u`  | Move up half screen                                     |
| `ctrl+f`  | Move down one screen                                    |
| `ctrl+d`  | Move down half screen                                   |
| `/`       | Search forward                                          |
| `?`       | Search backward                                         |
| `n`       | Next keyword occurrence                                 |
| `N`       | Previous keyword occurrence                             |

## Troubleshooting

### `ctrl+b` in Copy Mode does not work

If you don't set the leader key or explicitly set it to `ctrl+b`, it will
conflict with `ctrl+b` (Move up one screen) in Copy Mode.
Please set the leader key to something other than `ctrl+b`.
