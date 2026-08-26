hl.config({
  binds = {
    allow_pin_fullscreen     = true,
    allow_workspace_cycles   = true,
    workspace_center_on      = 1,
    workspace_back_and_forth = false,
  },
})

-- █ █ ▄▀█ █▀█ █ ▄▀█ █▄▄ █   █▀▀ █▀
-- ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█

local meta  = "SUPER"
local hyper = "MOD3"

local home             = os.getenv("HOME")
local bin              = home .. "/.local/bin"
local scripts          = home .. "/.config/hypr/scripts"
local launcher_scripts = home .. "/.config/rofi/scripts"

local moveactivewindow =
  'grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive'

local function launch(cmd) return cmd .. " & disown; hyprctl dispatch submap reset" end

-- █▄▀ █▀▀ █▄█ █▄▄ █ █▄ █ █▀▄ █ █▄ █ █▀▀ █▀
-- █ █ ██▄  █  █▄█ █ █ ▀█ █▄▀ █ █ ▀█ █▄█ ▄█

-- hl.bind(meta .. " + P", hl.dsp.window.pin())
hl.bind(meta .. " + P", hl.dsp.exec_cmd(scripts .. "/pin"))
-- hl.bind(meta .. " + O", hl.dsp.window.pseudo())
hl.bind(meta .. " + S", hl.dsp.layout("togglesplit"))
hl.bind(meta .. " + F", hl.dsp.window.fullscreen(0))
hl.bind(meta .. " + SHIFT + F", hl.dsp.window.fullscreen(1))
hl.bind(meta .. " + U", hl.dsp.focus({ urgent_or_last = true }))
hl.bind(meta .. " + SPACE", hl.dsp.exec_cmd(scripts .. "/toggle_floating"))
hl.bind(meta .. " + " .. hyper .. " + SPACE", hl.dsp.exec_cmd(scripts .. "/allfloat"))
hl.bind(meta .. " + C", hl.dsp.window.center())
hl.bind(meta .. " + " .. hyper .. " + P", performance)
hl.bind(meta .. " + " .. hyper .. " + ESCAPE", hl.dsp.exec_cmd("wl-freeze -a -s"))
hl.bind(meta .. " + ALT + BACKSPACE", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }))
hl.bind(meta .. " + ALT + SHIFT + BACKSPACE", hl.dsp.exec_cmd(scripts .. "/gaps"))
hl.bind(meta .. " + ALT + 0", hl.dsp.exec_cmd(bin .. "/caffeine"))
hl.bind(meta .. " + Q", kill)
hl.bind(meta .. " + " .. hyper .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(hyper .. " + CTRL + DELETE", hl.dsp.exit()) -- Kill Hyprland

-- Pickers/Launchers
hl.bind("ALT + SPACE",                  hl.dsp.exec_cmd(launcher))
hl.bind(hyper .. " + CTRL + E",         hl.dsp.exec_cmd(scripts .. "/emoji"))
hl.bind(hyper .. " + CTRL + G",         hl.dsp.exec_cmd(scripts .. "/glyph"))
hl.bind(hyper .. " + CTRL + S",         hl.dsp.exec_cmd(scripts .. "/ocr"))
hl.bind(hyper .. " + CTRL + C",         hl.dsp.exec_cmd(scripts .. "/pigment"))
hl.bind(hyper .. " + CTRL + R",         hl.dsp.exec_cmd(bin .. "/screenrecord"))
-- hl.bind(hyper .. " + CTRL + R + SPACE", hl.dsp.exec_cmd(bin .. "/screenrecord -a"))
hl.bind(hyper .. " + ESCAPE + 9",       hl.dsp.exec_cmd(scripts .. "/gamemode"))
hl.bind(meta .. " + CTRL + W",          hl.dsp.exec_cmd(scripts .. "/webcam"))
-- hl.bind(hyper .. " + CTRL + E",         hl.dsp.exec_cmd(launcher_scripts .. "/emoji/emoji"))
hl.bind(meta .. " + ALT + SPACE",       hl.dsp.exec_cmd(launcher_scripts .. "/windows/windows"))
-- hl.bind(hyper .. " + CTRL + Y",         hl.dsp.exec_cmd(launcher_scripts .. "/clipboard/clipboard"))
hl.bind(meta .. " + ESCAPE",            hl.dsp.exec_cmd(launcher_scripts .. "/powermenu/powermenu"))
hl.bind(hyper .. " + RETURN",           hl.dsp.exec_cmd(launcher_scripts .. "/game-launcher/game_launcher"))
hl.bind("PRINT",                        hl.dsp.exec_cmd(launcher_scripts .. "/screenshot/screenshot --freeze"))
hl.bind("CTRL + ESCAPE",                hl.dsp.exec_cmd(launcher_scripts .. "/screenshot/screenshot --freeze"))
-- hl.bind("CTRL + ALT + M",               hl.dsp.exec_cmd(term .. " " .. bin .. "/hidpi"))
hl.bind(meta .. " + I",                 hl.dsp.exec_cmd(tmux .. " multiplexer"))
hl.bind(hyper .. " + BACKSLASH",        hl.dsp.exec_cmd("kitten quick-access-terminal"))

-- Notification Panel
hl.bind(meta .. " + N",         hl.dsp.exec_cmd(notifications_menu_toggle))
hl.bind(meta .. " + CTRL + N",  hl.dsp.exec_cmd(notifications_menu_read))
hl.bind(meta .. " + ALT + N",   hl.dsp.exec_cmd(notifications_menu_disturb))
hl.bind(meta .. " + SHIFT + N", hl.dsp.exec_cmd(notifications_menu_reload))

-- Wallpaper
-- hl.bind(meta .. " + SHIFT + W", hl.dsp.exec_cmd("pypr wall next"))
hl.bind(meta .. " + SHIFT + W", hl.dsp.exec_cmd(scripts .. "/wallpaper"))
hl.bind(meta .. " + W",         hl.dsp.exec_cmd(launcher_scripts .. "/wallpaper/wallpaper"))
-- hl.bind(meta .. " + SHIFT + W", hl.dsp.exec_cmd(scripts .. "/mpvpaper"))
-- hl.bind(meta .. " + W",         hl.dsp.exec_cmd(launcher_scripts .. "/wallpaper/mpvpaper"))

-- Apps
hl.bind(meta  .. " + RETURN",         hl.dsp.exec_cmd(term))
hl.bind(meta  .. " + SHIFT + RETURN", hl.dsp.exec_cmd(term_ALT))
hl.bind(meta  .. " + B",              hl.dsp.exec_cmd(browser))
hl.bind(hyper .. " + CTRL + P",       hl.dsp.exec_cmd(browser_ALT .. " --private-window"))
hl.bind(meta  .. " + E",              hl.dsp.exec_cmd(term .. " " .. file_mgr))
hl.bind(meta  .. " + SHIFT + E",      hl.dsp.exec_cmd(file_mgr_gui))

hl.bind(meta .. " + A", hl.dsp.submap("apps"))
hl.define_submap("apps", function()
  hl.bind("A", hl.dsp.exec_cmd(launch("android-file-transfer")))
  hl.bind("C", hl.dsp.exec_cmd(launch("gnome-calculator")))
  -- hl.bind("E", hl.dsp.exec_cmd(launch("easyeffects")))
  -- hl.bind("F", hl.dsp.exec_cmd(launch("fragments")))
  hl.bind("O", hl.dsp.exec_cmd(launch(notes)))
  hl.bind("Q", hl.dsp.exec_cmd(launch("qutebrowser")))
  hl.bind("S", hl.dsp.exec_cmd(launch("spotify")))
  hl.bind("T", hl.dsp.exec_cmd(launch(mail)))
  -- hl.bind("V", hl.dsp.exec_cmd(launch("vscodium")))
  hl.bind("Y", hl.dsp.exec_cmd(launch("org.nickvision.tubeconverter")))
  hl.bind("X", hl.dsp.exec_cmd(launch(editor_gui)))

  hl.bind("SHIFT + F", hl.dsp.exec_cmd(launch("firefox")))
  hl.bind("SHIFT + P", hl.dsp.exec_cmd(launch("packet")))
  hl.bind("SHIFT + S", hl.dsp.exec_cmd(launch("steam")))

  hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- Web Apps
hl.bind(meta .. " + X", hl.dsp.submap("links"))
hl.define_submap("links", function()
  hl.bind("C", hl.dsp.exec_cmd(launch(webapp .. " 'https://chatgpt.com/?temporary-chat=true'")))
  hl.bind("G", hl.dsp.exec_cmd(launch(webapp .. " 'https://gemini.google.com/app'")))
  hl.bind("P", hl.dsp.exec_cmd(launch(webapp .. " 'https://perplexity.ai'")))
  hl.bind("Q", hl.dsp.exec_cmd(launch(webapp .. " 'https://chat.qwen.ai'")))
  hl.bind("S", hl.dsp.exec_cmd(launch(webapp .. " 'https://web.localsend.org'")))
  hl.bind("X", hl.dsp.exec_cmd(launch(webapp .. " 'https://grok.com/'")))
  hl.bind("Y", hl.dsp.exec_cmd(launch(webapp .. " 'https://youtube.com'")))

  hl.bind("SHIFT + G", hl.dsp.exec_cmd(launch(webapp .. " 'https://github.com/azurehound'")))

  hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- Scratchpads
hl.bind(hyper .. " + CTRL + W", hl.dsp.exec_cmd("pypr toggle impala"))
hl.bind(hyper .. " + CTRL + B", hl.dsp.exec_cmd("pypr toggle bluetui"))
hl.bind(meta .. " + V",         hl.dsp.exec_cmd("pypr toggle wiremix"))
hl.bind(hyper .. " + CTRL + Y", hl.dsp.exec_cmd("pypr toggle clipboard"))

hl.bind(meta .. " + BACKSLASH", hl.dsp.exec_cmd("pypr toggle term"))
hl.bind(meta .. " + T",         hl.dsp.exec_cmd("pypr toggle tty-clock"))
hl.bind(hyper .. " + CTRL + N", hl.dsp.exec_cmd("pypr toggle quick-note"))

hl.bind(hyper .. " + B", hl.dsp.exec_cmd("pypr toggle btop"))
hl.bind(hyper .. " + D", hl.dsp.exec_cmd("pypr toggle lazydocker"))
hl.bind(hyper .. " + G", hl.dsp.exec_cmd("pypr toggle nvitop"))
-- hl.bind(hyper .. " + I", hl.dsp.exec_cmd("pypr toggle tgpt"))
hl.bind(hyper .. " + J", hl.dsp.exec_cmd("pypr toggle jelly"))
hl.bind(hyper .. " + L", hl.dsp.exec_cmd("pypr toggle lofi"))
hl.bind(hyper .. " + M", hl.dsp.exec_cmd("pypr toggle neomutt"))
hl.bind(hyper .. " + N", hl.dsp.exec_cmd("pypr toggle neovim"))
hl.bind(hyper .. " + O", hl.dsp.exec_cmd("pypr toggle obsidian"))
hl.bind(hyper .. " + P", hl.dsp.exec_cmd("pypr toggle pomodoro"))
hl.bind(hyper .. " + S", hl.dsp.exec_cmd("pypr toggle sounds"))
hl.bind(hyper .. " + T", hl.dsp.exec_cmd("pypr toggle todo"))
hl.bind(hyper .. " + W", hl.dsp.exec_cmd("pypr toggle weather"))
hl.bind(hyper .. " + V", hl.dsp.exec_cmd("pypr toggle vim"))
hl.bind(hyper .. " + X", hl.dsp.exec_cmd("pypr toggle tt"))
hl.bind(hyper .. " + Y", hl.dsp.exec_cmd("pypr toggle yazi"))

-- Focusing
-- hl.bind(meta .. " + TAB", hl.dsp.focus({ last = true }))
hl.bind(meta .. " + TAB", hl.dsp.focus({ workspace = "previous" }))
hl.bind(meta .. " + BACKSPACE", hl.dsp.exec_cmd(scripts .. "/toggle_focus"))

-- hl.bind(meta .. " + H", hl.dsp.focus({ direction = "l" }))
-- hl.bind(meta .. " + J", hl.dsp.focus({ direction = "d" }))
-- hl.bind(meta .. " + K", hl.dsp.focus({ direction = "u" }))
-- hl.bind(meta .. " + L", hl.dsp.focus({ direction = "r" }))

-- hl.bind(meta .. " + LEFT",  hl.dsp.focus({ direction = "l" }))
-- hl.bind(meta .. " + UP",    hl.dsp.focus({ direction = "u" }))
-- hl.bind(meta .. " + DOWN",  hl.dsp.focus({ direction = "d" }))
-- hl.bind(meta .. " + RIGHT", hl.dsp.focus({ direction = "r" }))

--- Window on Top
hl.bind("ALT + Tab", function()
  hl.dispatch(hl.dsp.window.cycle_next())
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

-- FIXME:
hl.bind(meta .. " + H", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(meta .. " + J", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(meta .. " + K", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(meta .. " + L", hl.dsp.window.alter_zorder({ mode = "top" }))

hl.bind(meta .. " + LEFT",  hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(meta .. " + UP",    hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(meta .. " + DOWN",  hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(meta .. " + RIGHT", hl.dsp.window.alter_zorder({ mode = "top" }))

--- Pypr
hl.bind(meta .. " + " .. hyper .. " + M", hl.dsp.exec_cmd("pypr layout_center toggle"))

hl.bind(meta .. " + H", hl.dsp.exec_cmd("pypr layout_center prev"))
hl.bind(meta .. " + J", hl.dsp.exec_cmd("pypr layout_center next2"))
hl.bind(meta .. " + K", hl.dsp.exec_cmd("pypr layout_center prev2"))
hl.bind(meta .. " + L", hl.dsp.exec_cmd("pypr layout_center next"))

hl.bind(meta .. " + LEFT",  hl.dsp.exec_cmd("pypr layout_center prev"))
hl.bind(meta .. " + UP",    hl.dsp.exec_cmd("pypr layout_center prev2"))
hl.bind(meta .. " + DOWN",  hl.dsp.exec_cmd("pypr layout_center next2"))
hl.bind(meta .. " + RIGHT", hl.dsp.exec_cmd("pypr layout_center next"))

-- █▀▄▀█ █▀█ █ █ █▀▀
-- █ ▀ █ █▄█ ▀▄▀ ██▄

hl.bind(meta .. " + " .. hyper .. " + BACKSPACE", hl.dsp.exec_cmd(scripts .. "/move_by_rules"))

hl.bind(meta .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(meta .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(meta .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(meta .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

hl.bind(
  meta .. " + SHIFT + LEFT",
  hl.dsp.exec_cmd(moveactivewindow .. " -10 0 || hyprctl dispatch movewindow l"),
  { repeating = true, locked = true }
)
hl.bind(
  meta .. " + SHIFT + UP",
  hl.dsp.exec_cmd(moveactivewindow .. " 0 -10 || hyprctl dispatch movewindow u"),
  { repeating = true, locked = true }
)
hl.bind(
  meta .. " + SHIFT + DOWN",
  hl.dsp.exec_cmd(moveactivewindow .. " 0 10  || hyprctl dispatch movewindow d"),
  { repeating = true, locked = true }
)
hl.bind(
  meta .. " + SHIFT + RIGHT",
  hl.dsp.exec_cmd(moveactivewindow .. " 10 0  || hyprctl dispatch movewindow r"),
  { repeating = true, locked = true }
)

-- Groups
hl.bind(meta .. " + G", hl.dsp.group.toggle())
hl.bind(meta .. " + SHIFT + G", hl.dsp.window.move({ out_of_group = true }))
hl.bind(meta .. " + " .. hyper .. " + G", hl.dsp.group.lock_active({ action = "toggle" }))

-- Moving in group
hl.bind(hyper .. " + CTRL + TAB", hl.dsp.group.next())
hl.bind(meta .. " + ALT + SHIFT + TAB", hl.dsp.group.prev())

-- Moving in group [Mouse]
hl.bind(meta .. " + CTRL + mouse_up", hl.dsp.group.next())
hl.bind(meta .. " + CTRL + mouse_down", hl.dsp.group.prev())

-- Moving to TAB
hl.bind(meta .. " + ALT + 1", hl.dsp.group.active({ index = 1 }))
hl.bind(meta .. " + ALT + 2", hl.dsp.group.active({ index = 2 }))
hl.bind(meta .. " + ALT + 3", hl.dsp.group.active({ index = 3 }))
hl.bind(meta .. " + ALT + 4", hl.dsp.group.active({ index = 4 }))
hl.bind(meta .. " + ALT + 5", hl.dsp.group.active({ index = 5 }))

-- █▀█ █▀▀ █▀ █ ▀█ █▀▀
-- █▀▄ ██▄ ▄█ █ █▄ ██▄

hl.bind(meta .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  hl.bind("H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
  hl.bind("L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })

  hl.bind("LEFT",  hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
  hl.bind("UP",    hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
  hl.bind("DOWN",  hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
  hl.bind("RIGHT", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })

  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Window Split
hl.bind(meta .. " + MINUS", hl.dsp.exec_cmd("hyprctl dispatch splitratio -0.1"))
hl.bind(meta .. " + EQUAL", hl.dsp.exec_cmd("hyprctl dispatch splitratio +0.1"))

-- █   █ █▀█ █▀█ █▄▀ █▀ █▀█ ▄▀█ █▀▀ █▀▀ █▀
-- █▄▀▄█ █▄█ █▀▄ █ █ ▄█ █▀▀ █▀█ █▄▄ ██▄ ▄█

-- Workspaces 1..10
for i = 1, 10 do
  local key = i % 10 -- 10 -> 0
  hl.bind(meta .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(meta .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
  hl.bind(meta .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Moving to Workspace
hl.bind(meta .. " + CTRL + H", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(meta .. " + CTRL + J", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(meta .. " + CTRL + K", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(meta .. " + CTRL + L", hl.dsp.focus({ workspace = "m+1" }))

hl.bind(meta .. " + CTRL + LEFT",  hl.dsp.focus({ workspace = "m-1" }))
hl.bind(meta .. " + CTRL + DOWN",  hl.dsp.focus({ workspace = "e-1" }))
hl.bind(meta .. " + CTRL + UP",    hl.dsp.focus({ workspace = "e+1" }))
hl.bind(meta .. " + CTRL + RIGHT", hl.dsp.focus({ workspace = "m+1" }))

hl.bind(hyper .. " + SHIFT + H", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(hyper .. " + SHIFT + L", hl.dsp.window.move({ workspace = "r+1" }))

hl.bind(hyper .. " + SHIFT + BRACKETLEFT",  hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(hyper .. " + SHIFT + BRACKETRIGHT", hl.dsp.window.move({ workspace = "r+1" }))

hl.bind(hyper .. " + CTRL + H", hl.dsp.window.move({ workspace = "r-1", follow = false }))
hl.bind(hyper .. " + CTRL + L", hl.dsp.window.move({ workspace = "r+1", follow = false }))

hl.bind(hyper .. " + CTRL + BRACKETLEFT",  hl.dsp.window.move({ workspace = "r-1", follow = false }))
hl.bind(hyper .. " + CTRL + BRACKETRIGHT", hl.dsp.window.move({ workspace = "r+1", follow = false }))

-- Workspaces Overview
hl.bind(hyper .. " + CTRL + ESCAPE", hl.dsp.exec_cmd("pypr expose")) -- BACKSLASH

-- Minimize Workspaces
hl.bind(meta .. " + D", hl.dsp.exec_cmd(scripts .. "/desktop"))
hl.bind(meta .. " + M", hl.dsp.exec_cmd("pypr toggle_special minimized"))
hl.bind(meta .. " + SHIFT + M", hl.dsp.workspace.toggle_special("minimized"))

-- Special Workspace
-- hl.bind(meta .. " + Z",         hl.dsp.workspace.toggle_special("stash"))
-- hl.bind(meta .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:stash", follow = false }))

-- Audio
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- Volume
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '/MUTED/ {print 0; next} {print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  )
)
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd(
    "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+; rmpc volume +5; wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true, locked = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd(
    "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-; rmpc volume -5; wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true, locked = true }
)

-- Microphone
hl.bind(
  "SHIFT + XF86AudioMute",
  hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle; wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '/MUTED/ {print 0; next} {print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  )
)
hl.bind(
  "SHIFT + XF86AudioRaiseVolume",
  hl.dsp.exec_cmd(
    "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%+; wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true, locked = true }
)
hl.bind(
  "SHIFT + XF86AudioLowerVolume",
  hl.dsp.exec_cmd(
    "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%-; wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true, locked = true }
)

-- Brightness
hl.bind(
  "F11",
  hl.dsp.exec_cmd(
    "CUR=$(ddcutil --bus=6 getvcp 10 | awk -F 'current value = ' '{print $2}' | awk -F, '{print $1}' | tr -d ' '); VAL=$((CUR - 5)); [ $VAL -lt 0 ]   && VAL=0;   ddcutil --bus=6 setvcp 10 $VAL & echo $VAL > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true }
)
hl.bind(
  "F12",
  hl.dsp.exec_cmd(
    "CUR=$(ddcutil --bus=6 getvcp 10 | awk -F 'current value = ' '{print $2}' | awk -F, '{print $1}' | tr -d ' '); VAL=$((CUR + 5)); [ $VAL -gt 100 ] && VAL=100; ddcutil --bus=6 setvcp 10 $VAL & echo $VAL > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true }
)

-- Zoom
hl.bind(hyper .. " + CTRL + Z", hl.dsp.exec_cmd("pypr zoom"))
hl.bind(hyper .. " + CTRL + BACKSPACE", zoom_0)

hl.bind(hyper .. " + CTRL + MINUS",       function() zoom(0.9) end, { repeating = true })
hl.bind(hyper .. " + CTRL + EQUAL",       function() zoom(1.1) end, { repeating = true })
hl.bind(hyper .. " + CTRL + KP_SUBTRACT", function() zoom(0.9) end, { repeating = true })
hl.bind(hyper .. " + CTRL + KP_ADD",      function() zoom(1.1) end, { repeating = true })

-- █▀▄▀█ ▄▀█ █▀ ▀█▀ █▀▀ █▀█   █   ▄▀█ █▄█ █▀█ █ █ ▀█▀
-- █ ▀ █ █▀█ ▄█  █  ██▄ █▀▄   █▄▄ █▀█  █  █▄█ █▄█  █

hl.bind(meta .. " + CTRL + EQUAL", hl.dsp.layout("addmaster"))
hl.bind(meta .. " + CTRL + MINUS", hl.dsp.layout("removemaster"))

hl.bind(meta .. " + SHIFT + MINUS", hl.dsp.layout("mfact -0.05"))
hl.bind(meta .. " + SHIFT + EQUAL", hl.dsp.layout("mfact +0.05"))

-- █▀ █▀▀ █▀█ █▀█ █   █   █ █▄ █ █▀▀   █   ▄▀█ █▄█ █▀█ █ █ ▀█▀
-- ▄█ █▄▄ █▀▄ █▄█ █▄▄ █▄▄ █ █ ▀█ █▄█   █▄▄ █▀█  █  █▄█ █▄█  █

-- Keybinds
hl.bind(meta .. " + ALT + P", hl.dsp.layout("promote"))     -- focused window in new col
hl.bind(meta .. " + ALT + F", hl.dsp.layout("fit active"))  -- center/fit

hl.bind(meta .. " + ALT + H", hl.dsp.layout("swapcol l"))
hl.bind(meta .. " + ALT + L", hl.dsp.layout("swapcol r"))

-- Columns
hl.bind(meta .. " + ALT + COMMA",  hl.dsp.layout("move -col"))
hl.bind(meta .. " + ALT + PERIOD", hl.dsp.layout("move +col"))

-- Windows
--- Moving
hl.bind(meta .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(meta .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(meta .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(meta .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

hl.bind(meta .. " + SHIFT + LEFT",  hl.dsp.window.move({ direction = "l" }))
hl.bind(meta .. " + SHIFT + UP",    hl.dsp.window.move({ direction = "u" }))
hl.bind(meta .. " + SHIFT + DOWN",  hl.dsp.window.move({ direction = "d" }))
hl.bind(meta .. " + SHIFT + RIGHT", hl.dsp.window.move({ direction = "r" }))

--- Resizing
hl.bind(meta .. " + ALT + MINUS", hl.dsp.layout("colresize -0.1"))
hl.bind(meta .. " + ALT + EQUAL", hl.dsp.layout("colresize +0.1"))

-- █▀▄▀█ █▀█ █ █ █▀ █▀▀   █▄▄ █ █▄ █ █▀▄ █ █▄ █ █▀▀ █▀
-- █ ▀ █ █▄█ █▄█ ▄█ ██▄   █▄█ █ █ ▀█ █▄▀ █ █ ▀█ █▄█ ▄█

hl.bind(meta .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(meta .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
-- hl.bind(meta .. " + mouse:274", hl.dsp.window.drag(), { mouse = true })

-- Focusing
hl.bind(meta .. " + mouse_up",   hl.dsp.focus({ direction = "l" }))
hl.bind(meta .. " + mouse_down", hl.dsp.focus({ direction = "r" }))

-- Resize
hl.bind(meta .. " + CTRL + mouse_up",    hl.dsp.window.resize({ x = -40, y = 0, relative = true }))
hl.bind(meta .. " + CTRL + mouse_down",  hl.dsp.window.resize({ x = 40, y = 0, relative = true }))
hl.bind(meta .. " + SHIFT + mouse_up",   hl.dsp.window.resize({ x = 0, y = -40, relative = true }))
hl.bind(meta .. " + SHIFT + mouse_down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }))

-- Moving to Workspace
hl.bind(meta .. " + " .. hyper .. " + mouse_up",   hl.dsp.focus({ workspace = "m-1" }))
hl.bind(meta .. " + " .. hyper .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))

-- Zoom
hl.bind(hyper .. " + CTRL + mouse_up",   function() zoom(0.9) end)
hl.bind(hyper .. " + CTRL + mouse_down", function() zoom(1.1) end)

-- █ █ █▀▄▀█
-- ▀▄▀ █ ▀ █

hl.bind("CTRL + " .. meta .. " + ALT + P", hl.dsp.submap("passthru"))
hl.define_submap("passthru", function() hl.bind("CTRL + " .. meta .. " + ALT + P", hl.dsp.submap("reset")) end)

-- Windows VM
hl.bind(
  hyper .. " + CTRL + BACKSLASH",
  hl.dsp.exec_cmd("[float; size 60% 70%; center] " .. term .. " " .. bin .. "/windows")
)

-- Windows VM Desktop
hl.bind(
  "CTRL + " .. meta .. " + ALT + W",
  hl.dsp.exec_cmd(bin .. "/windows --desktop")
)
