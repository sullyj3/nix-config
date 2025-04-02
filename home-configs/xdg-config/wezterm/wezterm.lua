local wezterm = require("wezterm")

local keys = {
    {
        key="Enter",
        mods="ALT",
        action=wezterm.action.DisableDefaultAssignment
	}
}

local config = {
    color_scheme = "Kanagawa (Gogh)",
    keys = keys,
    hide_tab_bar_if_only_one_tab = true,
    font_size = 11,
    window_decorations = "NONE"
}

return config
