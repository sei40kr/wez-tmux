# wez-tmux

Port [tmux](https://github.com/tmux/tmux) key bindings to [WezTerm](https://wezterm.org), bringing familiar tmux navigation patterns to modern terminal emulator.

> **Note**: This plugin ports tmux **key bindings only**, not the complete workflow or session management system.

## 🗺️ Concept Mapping: tmux ↔ WezTerm

| tmux Concept   | WezTerm Equivalent | Description                                                         |
| -------------- | ------------------ | ------------------------------------------------------------------- |
| **Session**    | **Workspace**      | Isolated environments for different projects/contexts               |
| **Window**     | **Tab**            | Multiple terminal views within a session/workspace                  |
| **Pane**       | **Pane**           | Split views within a window/tab                                     |
| **Prefix key** | **Leader key**     | Modifier key that activates tmux-style commands (default: `Ctrl+b`) |
| **Copy mode**  | **Copy mode**      | Text selection and navigation mode with enhanced capabilities       |

## ✨ Features

- **Familiar Key Bindings**: All major tmux key combinations supported
- **Basic Navigation**: tmux-style pane splitting, navigation, and resizing
- **Copy Mode**: Enhanced text selection with tmux navigation patterns
- **Customizable**: Easy configuration and leader key customization
- **Native Integration**: Leverages WezTerm's native capabilities

## 🚀 Installation

### Method 1: Git Clone (Recommended)

```bash
# Clone into your WezTerm plugins directory
git clone https://github.com/sei40kr/wez-tmux.git "${XDG_CONFIG_HOME:-$HOME/.config}/wezterm/plugins/wez-tmux"
```

### Method 2: Manual Installation

1. Download or clone this repository
2. Place the `plugin` directory in your WezTerm plugins path:
   ```bash
   # Typically:
   cp -r wez-tmux/plugin ~/.config/wezterm/plugins/wez-tmux/
   ```

## ⚙️ Configuration

Add to your `wezterm.lua` configuration file:

```lua
local wezterm = require("wezterm")

-- Initialize config with wezterm.config_builder() for forward compatibility
local config = wezterm.config_builder()

-- Configure your leader key (recommended to avoid conflicts)
config.leader = { key = "a", mods = "CTRL" }  -- Use Ctrl+a instead of default Ctrl+b

-- Apply wez-tmux plugin with optional configuration
require("plugins.wez-tmux.plugin").apply_to_config(config, {
    -- Optional: Customize tab index base (0-based or 1-based)
    -- tab_and_split_indices_are_zero_based = true
})

return config
```

## ⌨️ Comprehensive Key Bindings Reference

### Leader Key Basics

| Key Combination   | Description                        |
| ----------------- | ---------------------------------- |
| `leader + leader` | Send the leader key itself         |
| `leader + [`      | Enter copy mode for text selection |

### Workspace Management (tmux Sessions)

| Key Combination | Description                    |
| --------------- | ------------------------------ |
| `leader + $`    | Rename current workspace       |
| `leader + s`    | Interactive workspace switcher |
| `leader + (`    | Switch to previous workspace   |
| `leader + )`    | Switch to next workspace       |

### Tab Operations (tmux Windows)

| Key Combination | Description                           |
| --------------- | ------------------------------------- |
| `leader + c`    | Create new tab in current domain      |
| `leader + &`    | Close current tab (with confirmation) |
| `leader + p`    | Switch to previous tab                |
| `leader + n`    | Switch to next tab                    |
| `leader + l`    | Switch to last active tab             |
| `leader + 1-9`  | Switch to specific tab by index       |

### Pane Management

#### Splitting & Navigation

| Key Combination  | Description                    |
| ---------------- | ------------------------------ |
| `leader + %`     | Split pane horizontally        |
| `leader + "`     | Split pane vertically          |
| `leader + {`     | Rotate panes counter-clockwise |
| `leader + }`     | Rotate panes clockwise         |
| `leader + arrow` | Navigate to pane in direction  |
| `leader + q`     | Interactive pane selector      |

#### Resizing & Operations

| Key Combination         | Description                            |
| ----------------------- | -------------------------------------- |
| `leader + z`            | Zoom/unzoom current pane               |
| `leader + !`            | Move pane to new tab                   |
| `leader + ctrl + arrow` | Resize pane in direction (5 cells)     |
| `leader + x`            | Close current pane (with confirmation) |

### Copy Mode (Advanced Text Selection)

#### Navigation

| Key Combination | Description                |
| --------------- | -------------------------- |
| `h/j/k/l`       | Basic directional movement |
| `w/b/e`         | Word-based navigation      |
| `0`             | Beginning of line          |
| `$`             | End of line content        |
| `^`             | Start of line content      |
| `g`             | Top of scrollback          |
| `G`             | Bottom of scrollback       |
| `H/M/L`         | Viewport positioning       |

#### Scrolling & Paging

| Key Combination | Description           |
| --------------- | --------------------- |
| `ctrl + b`      | Page up               |
| `ctrl + f`      | Page down             |
| `ctrl + u`      | Scroll up half page   |
| `ctrl + d`      | Scroll down half page |

#### Search & Selection

| Key Combination | Description             |
| --------------- | ----------------------- |
| `/`             | Search forward          |
| `?`             | Search backward         |
| `n`             | Next search result      |
| `N`             | Previous search result  |
| `v`             | Cell selection mode     |
| `shift + v`     | Line selection mode     |
| `ctrl + v`      | Block selection mode    |
| `y`             | Copy selection and exit |
| `Escape`        | Clear selection or exit |

## 🛠️ Advanced Configuration

### Custom Leader Key

```lua
-- Use Ctrl+Space as leader (recommended for minimal conflicts)
config.leader = { key = "Space", mods = "CTRL" }

-- Or use a letter key with modifier
config.leader = { key = "a", mods = "CTRL" }      -- Ctrl+a
config.leader = { key = "Space", mods = "ALT" }   -- Alt+Space
```

### Zero-based vs One-based Indexing

```lua
require("wez-tmux.plugin").apply_to_config(config, {
    -- Use 0-based indexing for tabs (leader+0 for first tab)
    tab_and_split_indices_are_zero_based = true,

    -- Or keep 1-based indexing (default, leader+1 for first tab)
    tab_and_split_indices_are_zero_based = false,
})
```

## 🔧 Troubleshooting

### Common Issues

#### Copy Mode `Ctrl+b` Conflict

**Problem**: `Ctrl+b` doesn't work in copy mode for page up

**Solution**: Use a different leader key than `Ctrl+b`:

```lua
config.leader = { key = "a", mods = "CTRL" }  -- Use Ctrl+a instead
```

#### Key Binding Conflicts

**Problem**: Custom key bindings not working

**Solution**: Load wez-tmux after your custom bindings, or use `wezterm.GLOBAL` for advanced customization

#### Plugin Not Found

**Problem**: `require("plugins.wez-tmux.plugin")` fails

**Solution**: Ensure the plugin directory is in your WezTerm plugins path:

```lua
-- Add this if plugin isn't found automatically
package.path = package.path .. ";" .. wezterm.config_dir .. "/plugins/wez-tmux/?.lua"
```
