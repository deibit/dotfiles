local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("JetBrains Mono", { weight = "DemiBold" })
config.font_size = 14
config.color_scheme = "Tokyo Night"
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

return config
