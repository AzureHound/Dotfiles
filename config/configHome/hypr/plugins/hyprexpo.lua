-- https://github.com/sandwichfarm/hyprexpo

local home = os.getenv("HOME")
dofile(home .. "/Developer/dotfiles/config/configHome/hypr/theme/colors.lua")

-- Conf
hl.config({
  plugin = {
    hyprexpo = {
      columns = 3,
      gaps_in = 6,
      gaps_out = 0,
      bg_col = colors.surface0,
      workspace_method = "first 1",

      keynav_enable = 1,
      label_enable = 0,
      border_width = 2,
      border_color_current = colors.rosewater,
      border_color_focus = colors.mauve,
      border_color_hover = colors.overlay0,

      drag_drop_proxy_color = "rgba(8aadf422)",
      drag_drop_proxy_active_color = "rgba(6e738d44)",
      drag_drop_proxy_border_color = "rgba(b7bdf8ee) rgba(8bd5caee) 45deg",
      drag_drop_source_border_color = colors.yellow,
      drag_drop_proxy_border_width = 3,
      drag_drop_proxy_rounding = 0,
    },
  },
})

-- Keybinds
hl.bind("ALT + ESCAPE", function()
  hl.plugin.hyprexpo.expo("toggle")
  hl.dsp.submap("hyprexpo")
end)

hl.define_submap("hyprexpo", function()
  hl.bind("h", function() hl.plugin.hyprexpo.kb_focus("left") end)
  hl.bind("j", function() hl.plugin.hyprexpo.kb_focus("down") end)
  hl.bind("k", function() hl.plugin.hyprexpo.kb_focus("up") end)
  hl.bind("l", function() hl.plugin.hyprexpo.kb_focus("right") end)

  hl.bind("left",  function() hl.plugin.hyprexpo.kb_focus("left") end)
  hl.bind("right", function() hl.plugin.hyprexpo.kb_focus("right") end)
  hl.bind("up",    function() hl.plugin.hyprexpo.kb_focus("up") end)
  hl.bind("down",  function() hl.plugin.hyprexpo.kb_focus("down") end)

  hl.bind("return", function() hl.plugin.hyprexpo.kb_confirm() hl.dsp.submap("reset") end)
  hl.bind("escape", function() hl.plugin.hyprexpo.expo("cancel") hl.dsp.submap("reset") end)

  hl.bind("1", function() hl.plugin.hyprexpo.kb_selecti(1) end)
  hl.bind("2", function() hl.plugin.hyprexpo.kb_selecti(2) end)
  hl.bind("3", function() hl.plugin.hyprexpo.kb_selecti(3) end)
  hl.bind("4", function() hl.plugin.hyprexpo.kb_selecti(4) end)
  hl.bind("5", function() hl.plugin.hyprexpo.kb_selecti(5) end)
  hl.bind("6", function() hl.plugin.hyprexpo.kb_selecti(6) end)
  hl.bind("7", function() hl.plugin.hyprexpo.kb_selecti(7) end)
  hl.bind("8", function() hl.plugin.hyprexpo.kb_selecti(8) end)
  hl.bind("9", function() hl.plugin.hyprexpo.kb_selecti(9) end)
  hl.bind("0", function() hl.plugin.hyprexpo.kb_selecti(10) end)

  hl.bind("catchall", function() hl.dsp.submap("reset") end)
end)
