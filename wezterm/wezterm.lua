local wezterm = require("wezterm")
local config = wezterm.config_builder()

local mux = wezterm.mux
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- Font
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
	{ family = "SauceCodePro Nerd Font", weight = "DemiBold" },
	{ family = "JetBrains Mono", weight = "Medium" },
})
config.font_size = 13

-- Window
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- Tabs
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false

-- Keymaps
config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

return config
