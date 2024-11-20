local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 17
config.color_scheme = "catppuccin-mocha"

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

return config
