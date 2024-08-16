local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Rosé Pine (Gogh)"

config.font = wezterm.font({ family = "FiraCode NFM" })
config.font_size = 13.0

return config
