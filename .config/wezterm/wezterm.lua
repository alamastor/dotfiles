local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Rosé Pine (Gogh)"

config.font = wezterm.font({ family = "FiraCode NFM" })
if wezterm.hostname() == "al-arch" then
	config.font_size = 11.0
else
	config.font_size = 13.0
end

config.enable_wayland = false

config.audible_bell = "Disabled"

config.keys = {}

for i = 1, 8 do
  -- CTRL+ALT + number to move to that position
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL|ALT',
    action = wezterm.action.MoveTab(i - 1),
  })
end


return config
