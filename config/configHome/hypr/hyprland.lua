-- █ █ █▄█ █▀█ █▀█ █   ▄▀█ █▄ █ █▀▄
-- █▀█  █  █▀▀ █▀▄ █▄▄ █▀█ █ ▀█ █▄▀

local conf = os.getenv("HOME") .. "/Developer/dotfiles/config/configHome/hypr"

-- Configs
dofile(conf .. "/configs/apps.lua")
dofile(conf .. "/configs/func.lua")
dofile(conf .. "/configs/binds.lua")
dofile(conf .. "/configs/env.lua")
dofile(conf .. "/configs/input.lua")
dofile(conf .. "/configs/layouts.lua")
dofile(conf .. "/configs/misc.lua")
dofile(conf .. "/configs/monitors.lua")
dofile(conf .. "/configs/plugins.lua")
dofile(conf .. "/configs/workspaces.lua")
dofile(conf .. "/theme/theme.lua")

-- Autostart
hl.on("hyprland.start", function()
  local autostart = conf .. "/scripts/autostart/"
  hl.exec_cmd(autostart .. "apps")
  hl.exec_cmd(autostart .. "services")
end)
