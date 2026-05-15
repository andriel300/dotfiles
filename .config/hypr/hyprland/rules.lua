-- ══════════════════════════════════════════════
-- WINDOW RULES
-- ══════════════════════════════════════════════

-- Suppress maximize for all windows
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Idle inhibit while fullscreen
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })

-- xdg-desktop-portal-gtk
hl.window_rule({ match = { class = "^([Xx]dg-desktop-portal-gtk)$" }, float = true })

-- Emoji Picker (smile)
hl.window_rule({
	match = { class = "(it.mijorus.smile)" },
	float = true,
	pin = true,
	move = "(monitor_w - window_w - 40) 90",
})
hl.window_rule({ match = { class = "^(it.mijorus.smile)$" }, opacity = "0.70 0.70 1.0" })

-- Pavucontrol
hl.window_rule({
	match = { class = "(.*org.pulseaudio.pavucontrol.*)" },
	float = true,
	size = { 700, 600 },
	center = true,
	pin = true,
})

-- qbittorrent
hl.window_rule({ match = { class = "(org.qbittorrent.qBittorrent)" }, float = true, size = { 1280, 720 } })
hl.window_rule({ match = { title = "^Remove torrent\\(s\\)$" }, float = true, size = { 900, 500 }, center = true })

-- qalculate-gtk
hl.window_rule({
	match = { class = "(qalculate-gtk)" },
	float = true,
	size = { 700, 600 },
	opacity = "0.70 0.70",
	center = true,
})

-- Gnome apps
hl.window_rule({ match = { class = "^(org.gnome.gedit)$" }, float = true, size = { 720, 720 } })

-- Browser (zen)
hl.window_rule({ match = { class = "^(zen)$", title = "^(Page Info)(.*)$" }, float = true })
hl.window_rule({ match = { class = "^(zen)$", title = "^(About Zen Browser)(.*)$" }, float = true })

-- Picture-in-Picture
hl.window_rule({
	match = { title = "^(Picture-in-Picture)$" },
	float = true,
	pin = true,
	move = "(monitor_w - 785) (monitor_h - 486)",
	size = { 785, 486 },
	opacity = "1.0 1.0",
	keep_aspect_ratio = true,
})

-- Terminal monitors (matched by initial_title)
hl.window_rule({ match = { class = "^(.*)$", initial_title = "^(.*)(top)(.*)$" }, float = true })
hl.window_rule({ match = { class = "^(.*)$", initial_title = "^(.*)(btop)(.*)$" }, float = true })
hl.window_rule({ match = { class = "^(.*)$", initial_title = "^(.*)(htop)(.*)$" }, float = true })

-- Zoom menu window
hl.window_rule({ match = { class = "(zoom)", initial_title = "(menu window)" }, stay_focused = true })

-- Fix XWayland dragging (unfocusable ghost windows)
hl.window_rule({
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

-- Steam
hl.window_rule({ match = { class = "^steam_app\\d+$" }, fullscreen = true })
hl.window_rule({ match = { class = "^steam_app_\\d+$" }, monitor = 1, workspace = "10" })

hl.workspace_rule({ workspace = "10", border_size = 0 })
hl.window_rule({ match = { workspace = "10" }, rounding = 0 })

hl.window_rule({
	match = { class = "^(steamwebhelper)$" },
	float = true,
	size = { 800, 600 },
	center = true,
	opacity = "0.80 0.80 1.0",
})
hl.window_rule({
	match = { class = "^([Ss]team)$", title = "^([Ss]team)$" },
	workspace = "3 silent",
	tile = true,
})
hl.window_rule({ match = { class = "^([Ss]team)$", title = "negative:^([Ss]team)$" }, float = true })
hl.window_rule({ match = { class = "^([Ss]team)$" }, opacity = "0.80 0.80 1.0" })

-- Media
hl.window_rule({ match = { class = "^(vlc)$" }, idle_inhibit = "always" })

-- Waypaper
hl.window_rule({
	match = { class = "(.*waypaper.*)" },
	float = true,
	size = { 900, 700 },
	center = true,
	pin = true,
})

-- KDE / GNOME / QT
hl.window_rule({ match = { class = "^(kvantummanager)$" }, float = true })
hl.window_rule({ match = { class = "^(qt5ct)$" }, float = true })
hl.window_rule({ match = { class = "^(qt6ct)$" }, float = true })
hl.window_rule({
	match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" },
	opacity = "0.80 0.70 1.0",
	float = true,
})
hl.window_rule({ match = { class = "^(polkit-gnome-authentication-agent-1)$" }, opacity = "0.80 0.70 1.0" })

-- YAD
hl.window_rule({
	match = { class = "^(yad)$" },
	float = true,
	opacity = "0.80 0.80",
	move = "(monitor_w * 0.44) (monitor_h * 0.04)",
})

-- GNOME Calendar
hl.window_rule({
	match = { class = "^(org.gnome.Calendar)$" },
	float = true,
	opacity = "0.85 0.85",
	move = "(monitor_w * 0.3) (monitor_h * 0.04)",
})

-- Common file dialogs / modals
hl.window_rule({ match = { title = "^(Open)$" }, float = true })
hl.window_rule({ match = { title = "^(Open Files)$" }, float = true })
hl.window_rule({ match = { title = "^(Choose Files)$" }, float = true })
hl.window_rule({ match = { title = "^(Save As)$" }, float = true })
hl.window_rule({ match = { title = "^(Confirm to replace files)$" }, float = true })
hl.window_rule({ match = { title = "^(File Operation Progress)$" }, float = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, float = true })

-- Spotify
hl.window_rule({ match = { initial_title = "^(Spotify Free)$" }, opacity = "0.80 0.80 1.0" })
hl.window_rule({ match = { initial_title = "^(Spotify Premium)$" }, opacity = "0.80 0.80 1.0" })
hl.window_rule({ match = { class = "^(Spotify)$" }, opacity = "0.80 0.80 1.0" })

-- Discord / Vesktop
hl.window_rule({ match = { class = "^(vesktop)$" }, opacity = "0.80 0.80", workspace = "2 silent" })
hl.window_rule({ match = { class = "^(discord)$" }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(WebCord)$" }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(ArmCord)$" }, opacity = "0.80 0.80" })

-- nwg
hl.window_rule({ match = { class = "^(nwg-look)$" }, float = true })
hl.window_rule({
	match = { class = "(nwg-displays)" },
	float = true,
	size = { 700, 600 },
	move = "(monitor_w * 0.1) (monitor_h * 0.2)",
	pin = true,
})

-- Misc apps
hl.window_rule({ match = { class = "^(com.rtosta.zapzap)$" }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = "^(org.kde.dolphin)$" }, opacity = "0.80 0.80 1.0" })
hl.window_rule({ match = { class = "^(org.kde.ark)$" }, opacity = "0.80 0.80 1.0", float = true })
hl.window_rule({ match = { class = "^(org.qbittorrent.qBittorrent)$" }, opacity = "0.70 0.70" })

-- Nautilus
hl.window_rule({
	match = { class = "^(org.gnome.Nautilus)" },
	opacity = "0.70 0.70",
	float = true,
	size = { 950, 720 },
})

-- Thunar
hl.window_rule({
	match = { class = "^([Tt]hunar)" },
	opacity = "0.70 0.70",
	float = true,
	size = { 950, 720 },
})
hl.window_rule({ match = { class = "([Tt]hunar)", title = "(File Operation Progress)" }, center = true })
hl.window_rule({ match = { class = "([Tt]hunar)", title = "(Confirm to replace files)" }, center = true })

-- Portals
hl.window_rule({ match = { class = "^(org.freedesktop.impl.portal.desktop.gtk)$" }, opacity = "0.80 0.70 1.0" })
hl.window_rule({ match = { class = "^(org.freedesktop.impl.portal.desktop.hyprland)$" }, opacity = "0.80 0.70 1.0" })

-- Dolphin dialogs
hl.window_rule({ match = { class = "^(org.kde.dolphin)$", title = "^(Progress Dialog — Dolphin)$" }, float = true })
hl.window_rule({ match = { class = "^(org.kde.dolphin)$", title = "^(Copying — Dolphin)$" }, float = true })

-- Ghostty monitors
hl.window_rule({ match = { class = "^(com.mitchellh.ghostty)$", title = "^(top)$" }, float = true })
hl.window_rule({ match = { class = "^(com.mitchellh.ghostty)$", title = "^(btop)$" }, float = true })
hl.window_rule({ match = { class = "^(com.mitchellh.ghostty)$", title = "^(htop)$" }, float = true })

-- Firefox / Zen library
hl.window_rule({ match = { class = "^(firefox)$", title = "^(Library)$" }, float = true })
hl.window_rule({ match = { class = "^(zen)$", title = "^(Library)$" }, float = true })

-- Image viewers
hl.window_rule({ match = { class = "^(eog)$" }, float = true })
hl.window_rule({ match = { class = "^(swayimg)$" }, float = true, size = { 800, 600 } })

-- Mission Center
hl.window_rule({
	match = { class = "(io.missioncenter.MissionCenter)" },
	float = true,
	pin = true,
	center = true,
	size = { 900, 600 },
})
hl.window_rule({
	match = { class = "(missioncenter)", title = "^(Preferences)$" },
	float = true,
	pin = true,
	center = true,
})

-- Evince
hl.window_rule({ match = { class = "(evince)" }, float = true, size = { 1280, 720 } })

-- 7-Zip
hl.window_rule({
	match = { class = "(7zFM)" },
	float = true,
	size = { 800, 600 },
	pin = true,
	move = "(monitor_w - window_w - 40) 90",
	opacity = "0.90 0.90",
})

-- EasyEffects / Fediverse
hl.window_rule({ match = { class = "^(com.github.wwmm.easyeffects)$" }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = "^(org.fagram.desktop)$" }, opacity = "0.90 0.90" })

-- Bottles
hl.window_rule({ match = { class = "(com.usebottles.bottles)" }, float = true, size = { 800, 600 } })

-- Zen — no border
hl.window_rule({ match = { class = "(zen)" }, border_size = 0 })

-- Satty (screenshot annotation)
hl.window_rule({ match = { class = "^(com.github.satty)$" }, float = true })
hl.window_rule({ match = { title = "^(satty)$" }, float = true })
hl.window_rule({ match = { class = "^(com.github.satty)", title = "^(satty)$" }, size = { 1620, 920 } })

-- XWayland video bridge (screen share fix — must be invisible)
hl.window_rule({
	match = { class = "^(xwaylandvideobridge)$" },
	opacity = 0.0,
	no_anim = true,
	no_initial_focus = true,
	max_size = { 1, 1 },
	no_blur = true,
	no_focus = true,
})

-- SwayNC windows
hl.window_rule({ match = { class = "(swaync-control-center)" }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "(swaync)" }, opacity = "0.80 0.80" })

-- Personal project
hl.window_rule({ match = { class = "^(secure-password-cli)$" }, float = true, size = { 600, 400 } })

-- Quickshell settings
hl.window_rule({ match = { class = "^org\\.quickshell$", title = "^Settings$" }, float = true, center = true })

-- Zen — Google Sign-in
hl.window_rule({
	match = { class = "^zen$", title = "^(Sign in - Google Accounts — Zen Browser)$" },
	float = true,
	center = true,
	size = { 800, 600 },
})

-- Evince (org.gnome.Evince)
hl.window_rule({ match = { class = "^org.gnome.Evince$" }, float = true, center = true, size = { 900, 900 } })

-- Stremio enhanced
hl.window_rule({ match = { class = "^stremio-enhanced" }, opacity = 0.9999 })

-- Steam notifications
hl.window_rule({ match = { class = "^(steam)$", title = "^(notificationtoasts)" }, no_initial_focus = true })
hl.window_rule({ match = { class = "^(steam)$", title = "^(notificationtoasts)" }, pin = true })

-- xdg-desktop-portal
hl.window_rule({ match = { class = "^(xdg-desktop-portal)$" }, float = true })


-- ══════════════════════════════════════════════
-- LAYER RULES
-- ══════════════════════════════════════════════

-- Rofi / Wofi
hl.layer_rule({ match = { namespace = "wofi" }, blur = true })
hl.layer_rule({ match = { namespace = "rofi" }, blur = true, ignore_alpha = 0 })

-- Notifications
hl.layer_rule({ match = { namespace = "notifications" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "notifications-window" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swww-daemon" }, blur = true, ignore_alpha = 0 })

-- Miscellaneous
hl.layer_rule({ match = { namespace = "hyprpicker" }, no_anim = true })
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })
hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })

-- hyprpanel
hl.layer_rule({ match = { namespace = "bar-0" }, blur = true })

-- Waybar
hl.layer_rule({ match = { namespace = "waybar" }, blur = true, blur_popups = true, ignore_alpha = 0.2 })

-- SwayNC
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0.5 })

-- DMS modals
hl.layer_rule({
	match = {
		namespace = "dms:(polkit|notification-center-modal|workspace-overview|clipboard|spotlight|settings|process-list-modal|dock)",
	},
	blur = true,
	ignore_alpha = 0,
})
hl.layer_rule({
	match = { namespace = "dms:(notification-popup|osd)" },
	blur = true,
	ignore_alpha = 0.5,
})

-- DMS shell components
hl.layer_rule({
	match = {
		namespace = "dms:(color-picker|control-center|app-launcher|vpn|battery|dash|notification-center-popout|bar|tooltip|toast|dock-context-menu|system-update|popout|process-list-popout)",
	},
	blur = true,
	ignore_alpha = 0,
})

-- DMS animations
hl.layer_rule({ match = { namespace = "dms:control-center" }, animation = "slide right" })
hl.layer_rule({ match = { namespace = "dms:workspace-overview" }, animation = "slide top" })
