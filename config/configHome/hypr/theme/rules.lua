-- █   █ █ █▄ █ █▀▄ █▀█ █ █ █   █▀█ █ █ █   █▀▀ █▀
-- █▄▀▄█ █ █ ▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█

-- Base Rules
local center_float = "^(.*xdg-desktop-portal-gtk.*)$"
hl.window_rule({ match = { class = center_float }, float = true })
hl.window_rule({ match = { class = center_float }, center = true })
hl.window_rule({ match = { class = center_float }, size = "(monitor_w*0.5) (monitor_h*0.5)" })

local center_float_title =
  "^(Open.*|Save.*|All Files|[Cc]hoose.*|.*wants to (open|save).*)$|^(.*(Add|Exclude|Include) (File|Folder|Directory).*)$|^(.*Select (Image|Move Destination|Extract Destination).*)$|^(.*(Library|Backup Location|File Upload|Install from VSIX|QEMU/KVM - Connection Details|Steam Settings|Profile Name|Open database|Open folder as vault|Open videos or images to compare).*)$"
hl.window_rule({ match = { title = center_float_title }, float = true })
hl.window_rule({ match = { title = center_float_title }, center = true })
hl.window_rule({ match = { title = center_float_title }, size = "(monitor_w*0.7) (monitor_h*0.7)" })

local center_float_mini = "^(.*org.gnome.Calculator.*|.*udiskie.*)$"
hl.window_rule({ match = { class = center_float_mini }, float = true })
hl.window_rule({ match = { class = center_float_mini }, center = true })
hl.window_rule({ match = { class = center_float_mini }, size = "(monitor_w*0.3) (monitor_h*0.4)" })

local center_float_large =
  "^(.*com\\.gabm\\.satty.*|.*Impression.*|.*iwgtk.*|.*mpv.*|.*org\\.gnome\\.Decibels.*|.*Overskride.*|.*pwvucontrol.*|.*qimgv.*|.*swayimg.*)$"
hl.window_rule({ match = { class = center_float_large }, float = true })
hl.window_rule({ match = { class = center_float_large }, center = true })
hl.window_rule({ match = { class = center_float_large }, size = "(monitor_w*0.7) (monitor_h*0.7)" })


-- Floats
hl.window_rule({
  match = {
    title = "branchdialog|confirm|confirmreset|dialog|download|error|file_progress|splash|notification|nwg-look",
  },
  float = true,
})

-- Workspaces
hl.window_rule({ match = { class = "^(.*zen.*)$" }, workspace = "2" })
-- hl.window_rule({ match = { class = "^(.*[Ff]irefox.*)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(.*virt-manager.*)$" }, workspace = "9" })

-- Gaming
hl.window_rule({ match = { class = "^(.*cemu.*|.*eden.*|.*steam_app.*|.*gamescope.*)$" }, workspace = "9" })
hl.window_rule({ match = { class = "^(.*[Ss]team.*)$" }, workspace = "9 silent" })
hl.window_rule({ match = { class = "^(steam_app_.*)$" }, workspace = "10" })

-- Media
hl.window_rule({ match = { class = "^(.*kdenlive.*)$" }, workspace = "6" })
hl.window_rule({ match = { class = "^(.*[Ss]potify.*)$" }, workspace = "7 silent" })
hl.window_rule({ match = { class = "^(.*thunderbird.*)$" }, workspace = "8 silent" })

-- Productivity/Dev
hl.window_rule({ match = { class = "^(.*VSCodium.*|.*neovide.*)$" }, workspace = "4" })
hl.window_rule({ match = { class = "^(.*obsidian.*)$" }, workspace = "8 silent" })


-- Apps
local keepassxc = "^(.*keepassxc.*)$"
hl.window_rule({ match = { class = keepassxc }, float = true })
hl.window_rule({ match = { class = keepassxc }, center = true })
-- hl.window_rule({ match = { class = keepassxc }, size = "(monitor_w*0.35) (monitor_h*0.9)" })

local localsend = "^(.*localsend.*|.*Share.*)$"
hl.window_rule({ match = { class = localsend }, float = true })
hl.window_rule({ match = { class = localsend }, center = true })

local preview = "^(.*org\\.gnome\\.NautilusPreviewer.*)$"
hl.window_rule({ match = { class = preview }, float = true })
hl.window_rule({ match = { class = preview }, center = true })
hl.window_rule({ match = { class = preview }, size = "(monitor_w*0.44) (monitor_h*0.96)" })

local scrcpy = "^(.*scrcpy.*)$"
hl.window_rule({ match = { class = scrcpy }, float = true })
hl.window_rule({ match = { class = scrcpy }, center = true })
hl.window_rule({ match = { title = "^(.*Pixel 4a.*)$|(.*Pixel 9a.*)" }, move = "(monitor_w*0.75) (monitor_h*0.02)" })

local steam = "^(.*steam_app.*)$"
hl.window_rule({ match = { class = steam }, no_anim = true })
hl.window_rule({ match = { class = steam }, no_blur = true })
hl.window_rule({ match = { class = steam }, opacity = "1 1" })
hl.window_rule({ match = { class = steam }, immediate = true })
hl.window_rule({ match = { class = steam }, fullscreen = true })
hl.window_rule({ match = { class = steam }, idle_inhibit = "always" })

local yazi = "^(terminal filechooser)$"
hl.window_rule({ match = { title = yazi }, float = true })
hl.window_rule({ match = { title = yazi }, center = true })
hl.window_rule({ match = { title = yazi }, size = "(monitor_w*0.84) (monitor_h*0.84)" })

local thunderbird = "^(.*thunderbird.*)$"
hl.window_rule({ match = { class = thunderbird, title = "^(.*Write.*)" }, float = true })
hl.window_rule({ match = { class = thunderbird, title = "^(.*Write.*)" }, center = true })
hl.window_rule({ match = { class = thunderbird, title = "^(.*Write.*)" }, size = "(monitor_w*0.7) (monitor_h*0.8)" })

local zathura = "^(.*zathura.*)$"
hl.window_rule({ match = { class = zathura }, float = true })
hl.window_rule({ match = { class = zathura }, center = true })
hl.window_rule({ match = { class = zathura }, size = "(monitor_w*0.35) (monitor_h*0.9)" })

-- Picture-in-Picture
local Pip = "^(.*Picture.?in.?[Pp]icture.*)$"
hl.window_rule({ match = { title = Pip }, float = true })
hl.window_rule({ match = { title = Pip }, pin = true })
hl.window_rule({ match = { title = Pip }, opacity = "1 1" })
hl.window_rule({ match = { title = Pip }, border_size = 0 })
hl.window_rule({ match = { title = Pip }, no_initial_focus = true })
hl.window_rule({ match = { title = Pip }, keep_aspect_ratio = true })
hl.window_rule({ match = { title = Pip }, focus_on_activate = false })
hl.window_rule({ match = { title = Pip }, size = "(monitor_w*0.26) (monitor_h*0.26)" })
hl.window_rule({ match = { title = Pip }, move = "(monitor_w*0.736) (monitor_h*0.009)" })
-- hl.window_rule({ match = { title = Pip }, move = "(monitor_w*0.734) (monitor_h*0.049)" })

-- Screensaver
local screensaver = "^(.*screensaver.*)$"
hl.window_rule({ match = { class = screensaver }, float = true })
hl.window_rule({ match = { class = screensaver }, no_anim = true })
hl.window_rule({ match = { class = screensaver }, fullscreen = true })

-- Screensharing with xWayland Apps
local videobridge = "^(.*xwaylandvideobridge.*)$"
hl.window_rule({ match = { class = videobridge }, no_anim = true })
hl.window_rule({ match = { class = videobridge }, no_blur = true })
hl.window_rule({ match = { class = videobridge }, max_size = "1 1" })
hl.window_rule({ match = { class = videobridge }, no_initial_focus = true })
hl.window_rule({ match = { class = videobridge }, opacity = "0.0 override 0.0 override" })

-- TMUX
local tmux = "^(.*session-init.*)$"
hl.window_rule({ match = { class = tmux }, no_anim = true })
hl.window_rule({ match = { class = tmux }, workspace = "1" })
-- hl.window_rule({ match = { class = tmux }, fullscreen = true })

-- Webcam Overlay
local webcam = "^(.*Webcam.*)$"
hl.window_rule({ match = { title = webcam }, pin = true })
hl.window_rule({ match = { title = webcam }, float = true })
hl.window_rule({ match = { title = webcam }, no_dim = true })
hl.window_rule({ match = { title = webcam }, no_anim = true })
hl.window_rule({ match = { title = webcam }, border_size = 0 })
hl.window_rule({ match = { title = webcam }, move = "1457 813" })
hl.window_rule({ match = { title = webcam }, no_initial_focus = true })
-- hl.window_rule({ match = { title = webcam }, move = "(monitor_w-463) (monitor_h-267)" })

-- Windows VM
local windows = "^(.*RAIL:.*)$"
hl.window_rule({ match = { class = windows }, rounding = 0 })
hl.window_rule({ match = { class = windows }, opacity = "1 override 1 override 1 override" })
hl.window_rule({ match = { class = windows }, border_color = "rgba(8aadf4ff) rgba(b7bdf8ff)" })


-- █▀█ █ █ █   █▀▀ █▀
-- █▀▄ █▄█ █▄▄ ██▄ ▄█

hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

hl.window_rule({ match = { title = "^(.*cava.*)$" }, animation = "slide" })

hl.window_rule({ match = { class = "^(kitty|footclient|ghostty|codium)$" }, opacity = "0.84 override 0.84 override" })
hl.window_rule({
  match = {
    class = "^(.*brave.*|.*mpv.*|.*eden.*|.*org\\.gnome\\.NautilusPreviewer.*|.*org\\.kde\\.kdenlive.*|.*wob.*|.*zen.*)$",
  },
  opacity = "1 override",
})

hl.window_rule({ match = { fullscreen = 1 }, no_blur = true })
hl.window_rule({ match = { float = 0 }, no_shadow = true })
hl.window_rule({ match = { class = "^(.*obsidian.*)$" }, no_screen_share = true })
hl.window_rule({ match = { class = "^(.*[Ss]potify.*)$" }, no_initial_focus = true })
hl.window_rule({ match = { title = "^(Sign in to Steam)$" }, no_initial_focus = true })
hl.window_rule({
  match = { class = "^$", title = "^$", xwayland = 1, float = 1, fullscreen = 0, pin = 0 },
  no_focus = true,
})
hl.window_rule({ match = { title = "^(Sign in to Steam)$" }, focus_on_activate = false })

hl.window_rule({ match = { tag = "noidle" }, idle_inhibit = "always" })
hl.window_rule({ match = { class = "^(.*[Ss]potify.*)$" }, idle_inhibit = "focus" })
hl.window_rule({ match = { class = "^(.*mpv.*|.*[Ff]irefox.*|.*zen.*)$" }, idle_inhibit = "fullscreen" })

hl.window_rule({ match = { class = "^(.*kitty.*|.*footclient.*)$", float = 1 }, rounding = 10 })

-- █   ▄▀█ █▄█ █▀▀ █▀█  █▀█ █ █ █   █▀▀ █▀
-- █▄▄ █▀█  █  ██▄ █▀▄  █▀▄ █▄█ █▄▄ ██▄ ▄█

hl.layer_rule({ match = { namespace = "slapper" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "hyprlock" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "selection" }, animation = "fade" })

hl.layer_rule({ match = { namespace = "wob" }, no_anim = true })
hl.layer_rule({ match = { namespace = "steam" }, no_anim = true })
hl.layer_rule({ match = { namespace = "hyprpaper" }, no_anim = true })
hl.layer_rule({ match = { namespace = "hyprpicker" }, no_anim = true })
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })

hl.layer_rule({ match = { namespace = "rofi" }, animation = "default" })
hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
-- hl.layer_rule({ match = { namespace = "rofi" }, dim_around = true })
hl.layer_rule({ match = { namespace = "rofi" }, ignore_alpha = 0 })

hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "waybar" }, ignore_alpha = 0 })

hl.layer_rule({ match = { namespace = "swaync-control-center" }, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, animation = "slide" })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, animation = "slide" })

hl.layer_rule({ match = { namespace = "zen" }, no_screen_share = true })
