local wezterm = require("wezterm")

local gpus = wezterm.gui.enumerate_gpus()
local wez = {}

function wez.tab_title(tab_info)
   local title = tab_info.tab_title
   if title and #title > 0 then
      return title
   end
   return tab_info.active_pane.title
end

wezterm.on('format-tab-title', function(tab, _, _, _, hover, _)
   local background = '#1b1032'
   local foreground = '#808080'

   if tab.is_active then
      background = '#92b3f4'
      foreground = '#313243'
   elseif hover then
      background = '#3b3052'
      foreground = '#909090'
   end

   local title = wez.tab_title(tab)

   return {
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
   }
end)

return {
   -- ColorSchemes.
   -- color_scheme = 'Gruvbox Material (Gogh)',
   -- color_scheme = 'GruvboxDark',
   color_scheme = 'Catppuccin Mocha',
   font = wezterm.font_with_fallback({
      { family = "SauceCodePro Nerd Font", weight = "DemiBold", },
      { family = "JetBrains Mono",         weight = "Medium" },
   }),
   font_size = 14,
   window_decorations = "RESIZE",

   webgpu_preferred_adapter = gpus[1],
   front_end = 'WebGpu',

   -- scrollbar
   enable_scroll_bar = false,

   -- window
   window_padding = {
      left = 5,
      right = 5,
      top = 7,
      bottom = 7,
   },
   window_close_confirmation = 'NeverPrompt',
   animation_fps = 120,

   window_frame = {
      font = wezterm.font_with_fallback({
         { family = "SauceCodePro Nerd Font", weight = "Bold", },
      }),
      font_size = 13,
      active_titlebar_bg = '#1e1e2d',
   },

   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = false,
   use_fancy_tab_bar = true,
   tab_max_width = 25,
   show_tab_index_in_tab_bar = false,
   switch_to_last_active_tab_when_closing_tab = true,

   mouse_bindings = {
      -- Ctrl-click will open the link under the mouse cursor
      {
         event = { Up = { streak = 1, button = "Left" } },
         action = wezterm.action.OpenLinkAtMouseCursor,
      },
   },
}
