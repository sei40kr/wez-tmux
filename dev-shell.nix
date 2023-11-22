{ mkShell, wezterm, wez-tmux, writeTextFile }:

let
  config = writeTextFile {
    name = "wez-tmux-dev-shell-config.lua";
    text = ''
      package.path = package.path .. ";${wez-tmux}/?.lua"

      local wezterm = require("wezterm")

      local config = {}

      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config.leader = { key = "b", mods = "CTRL" }

      require("plugin").apply_to_config(config, {})

      return config
    '';
  };
in
mkShell {
  name = "wez-tmux-dev-shell";

  packages = [ wezterm ];

  shellHook = ''
    alias wezterm="wezterm --config-file ${config}"
  '';
}
