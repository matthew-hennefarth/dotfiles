local wezterm = require("wezterm")
local config = {}

local is_linux <const> = wezterm.target_triple:find("linux") ~= nil
local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil

config.font = wezterm.font_with_fallback({
  "DinaRemasterII",
  "GohuFont 14 Nerd Font Mono",
})

--config.font = wezterm.font_with_fallback({
  --"IosevkaTerm Nerd Font",
--})


if is_darwin then
	config.font_size = 18
elseif is_linux then
	config.font_size = 12
end

config.bold_brightens_ansi_colors = false
config.use_cap_height_to_scale_fallback_fonts = true

config.color_scheme = "GruvboxDarkHard"

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- good for tiling window managers
config.adjust_window_size_when_changing_font_size = false

-- removes the title and decorations
config.window_decorations = "RESIZE"

return config
