-- $HYPRSCRIPTS was a hyprlang variable — resolved to the scripts path here
local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"
hl.env("PATH", os.getenv("PATH") .. ":" .. scripts)

-- Mouse cursor
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
-- XWayland cursor
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")

-- XDG Desktop Portal
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_MENU_PREFIX", "arch-")

-- QT
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_SCALE_FACTOR", "1")

-- SDL / Clutter
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- Firefox / Zen
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("EDITOR", "nvim")
hl.env("TERMINAL", "ghostty")
hl.env("BROWSER", "zen")

-- GDK
hl.env("GDK_SCALE", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")

-- Ozone (Electron / Chromium)
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- Grimblast
hl.env("GRIMBLAST_HIDE_CURSOR", "0")

-- Wayland display
hl.env("WAYLAND_DISPLAY", "wayland-0")

-- HDR
hl.env("DXVK_HDR", "1")
hl.env("ENABLE_HDR_WSI", "1")
