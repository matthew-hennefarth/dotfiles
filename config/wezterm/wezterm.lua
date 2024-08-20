local wezterm = require("wezterm")
local config = {}


config.font = wezterm.font_with_fallback({
	"DinaRemasterII",
	"GohuFont 14 Nerd Font Propo",
})

config.font_size = 18
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
